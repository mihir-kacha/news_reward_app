import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:inshorts/data/preference/preference.dart';

/// Google's Ad Manager sample native ad unit. Returns test creatives for every
/// request and is not tied to your network, so it cannot generate invalid
/// traffic. Used automatically in debug builds unless [useTestAdInDebug] is off.
const String kAdManagerNativeTestUnit = '/23026197400/example/native_android';

class AdManagerNativeAd extends StatelessWidget {
  final bool isShowAd;
  final String adUnitId;

  const AdManagerNativeAd({super.key, required this.isShowAd, required this.adUnitId});

  @override
  Widget build(BuildContext context) {
    if ((!isShowAd) || (!(Preference().adsConfig?.adsStatusModel?.showAdsInApp ?? false))) {
      return const SizedBox();
    }
    return _AdManagerNativeAd(adUnitId: adUnitId, isShowAd: isShowAd);
  }
}

/// A drop-in native ad slot for Google Ad Manager.
///
/// Pass an ad unit path and it handles loading, retries, disposal, list
/// recycling, and every failure state on its own.
///
/// ```dart
/// AdManagerNativeAd(
///   adUnitId: '/123456789/myapp_android/android_native_feed',
/// )
/// ```
///
/// Requires `MobileAds.instance.initialize()` to have been awaited in `main()`.
class _AdManagerNativeAd extends StatefulWidget {
  const _AdManagerNativeAd({
    super.key,
    required this.adUnitId,
    this.size = NativeAdSize.medium,
    this.height,
    this.isShowAd = true,
    this.padding = EdgeInsets.zero,
    this.customTargeting,
    this.maxRetries = 3,
    this.retryBaseDelay = const Duration(seconds: 4),
    this.reserveSpaceWhileLoading = true,
    this.collapseOnFailure = true,
    this.useTestAdInDebug = true,
    this.style,
    this.loadingBuilder,
    this.onLoaded,
    this.onFailed,
    this.onRevenue,
  });

  /// Full Ad Manager path, e.g. `/123456789/myapp_android/android_native_feed`.
  final String adUnitId;

  /// Template size. Drives the default reserved height.
  final NativeAdSize size;

  /// Overrides the height derived from [size]. Native ads need a bounded box —
  /// `AdWidget` has no intrinsic size and throws when unconstrained.
  final double? height;

  final EdgeInsets padding;

  final bool isShowAd;

  /// Ad Manager key-values sent with the request. Ad Manager only — this has no
  /// equivalent on the AdMob request path.
  final Map<String, String>? customTargeting;

  /// Attempts after the first failure. Set to 0 to never retry.
  final int maxRetries;

  /// Delay before the first retry. Doubles on each subsequent attempt.
  final Duration retryBaseDelay;

  /// Hold the slot open at full height while the first request is in flight.
  /// Prevents content jumping when the ad arrives.
  final bool reserveSpaceWhileLoading;

  /// Take up zero space once retries are exhausted, rather than leaving a gap.
  final bool collapseOnFailure;

  /// Swap [adUnitId] for [kAdManagerNativeTestUnit] in debug builds.
  final bool useTestAdInDebug;

  /// Overrides the default template styling.
  final NativeTemplateStyle? style;

  /// Shown while the first request is in flight. Defaults to a neutral block.
  final WidgetBuilder? loadingBuilder;

  final VoidCallback? onLoaded;

  /// Receives the final error after all retries are exhausted.
  final void Function(LoadAdError error)? onFailed;

  /// Fires on each paid impression. Wire this to your analytics for per-slot
  /// eCPM rather than relying on Ad Manager reporting alone.
  final void Function(double valueMicros, String currencyCode)? onRevenue;

  @override
  State<_AdManagerNativeAd> createState() => _AdManagerNativeAdState();
}

enum NativeAdSize { small, medium }

enum _SlotState { loading, loaded, failed }

class _AdManagerNativeAdState extends State<_AdManagerNativeAd> with AutomaticKeepAliveClientMixin {
  NativeAd? _ad;
  Timer? _retryTimer;
  _SlotState _state = _SlotState.loading;
  int _attempt = 0;

  // Keeps the loaded ad alive when the slot scrolls out of a ListView, so it
  // isn't torn down and re-requested every time it comes back into view.
  @override
  bool get wantKeepAlive => true;

  double get _slotHeight => widget.height ?? (widget.size == NativeAdSize.small ? 120 : 340);

  String get _resolvedUnitId => (kDebugMode && widget.useTestAdInDebug) ? kAdManagerNativeTestUnit : widget.adUnitId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void didUpdateWidget(_AdManagerNativeAd old) {
    super.didUpdateWidget(old);
    if (old.adUnitId != widget.adUnitId || old.size != widget.size) {
      _reset();
      _load();
    }
  }

  void _reset() {
    _retryTimer?.cancel();
    _retryTimer = null;
    _ad?.dispose();
    _ad = null;
    _attempt = 0;
    _state = _SlotState.loading;
  }

  void _load() {
    final ad = NativeAd(
      adUnitId: _resolvedUnitId,
      request: AdManagerAdRequest(customTargeting: widget.customTargeting),
      nativeTemplateStyle:
          widget.style ??
          NativeTemplateStyle(
            templateType: widget.size == NativeAdSize.small ? TemplateType.small : TemplateType.medium,
          ),
      listener: NativeAdListener(
        onAdLoaded: (loadedAd) {
          if (!mounted) {
            loadedAd.dispose();
            return;
          }
          setState(() {
            _ad = loadedAd as NativeAd;
            _state = _SlotState.loaded;
            _attempt = 0;
          });
          widget.onLoaded?.call();
        },
        onAdFailedToLoad: (failedAd, error) {
          failedAd.dispose();
          if (!mounted) return;
          _handleFailure(error);
        },
        onPaidEvent: (_, value, __, currency) => widget.onRevenue?.call(value, currency.toString()),
      ),
    );

    // A NativeAd instance is single-use; each attempt builds a fresh one.
    ad.load();
  }

  void _handleFailure(LoadAdError error) {
    if (_attempt < widget.maxRetries) {
      final delay = widget.retryBaseDelay * (1 << _attempt);
      _attempt++;
      _retryTimer?.cancel();
      _retryTimer = Timer(delay, () {
        if (mounted) _load();
      });
      return;
    }

    setState(() => _state = _SlotState.failed);
    widget.onFailed?.call(error);
    if (kDebugMode) {
      debugPrint(
        'Native ad gave up on $_resolvedUnitId — '
        'code ${error.code}: ${error.message}',
      );
    }
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    // Native ads hold platform-side view resources; skipping this leaks memory
    // in a way interstitials do not.
    _ad?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    switch (_state) {
      case _SlotState.loaded:
        return Padding(
          padding: widget.padding,
          child: SizedBox(
            height: _slotHeight,
            width: double.infinity,
            child: AdWidget(ad: _ad!),
          ),
        );

      case _SlotState.failed:
        if (widget.collapseOnFailure) return const SizedBox.shrink();
        return SizedBox(height: _slotHeight);

      case _SlotState.loading:
        if (!widget.reserveSpaceWhileLoading) return const SizedBox.shrink();
        return Padding(
          padding: widget.padding,
          child: SizedBox(
            height: _slotHeight,
            width: double.infinity,
            child: widget.loadingBuilder?.call(context) ?? _NativeAdSkeleton(size: widget.size),
          ),
        );
    }
  }
}

/// Skeleton that mirrors the arriving template's layout — icon, headline,
/// media, body, call to action — so the ad lands into a shape the eye has
/// already accepted instead of replacing a blank grey box.
///
/// Deliberately unlabelled: a "Loading ad" caption promises an impression the
/// slot may never deliver. The bones say "content is coming here" without
/// naming what it is.
class _NativeAdSkeleton extends StatefulWidget {
  const _NativeAdSkeleton({required this.size});

  final NativeAdSize size;

  @override
  State<_NativeAdSkeleton> createState() => _NativeAdSkeletonState();
}

class _NativeAdSkeletonState extends State<_NativeAdSkeleton> with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(vsync: this, duration: const Duration(milliseconds: 1600))
    ..repeat();

  @override
  void dispose() {
    _sweep.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final bone = scheme.onSurface.withValues(alpha: 0.07);
    final highlight = scheme.onSurface.withValues(alpha: 0.14);

    final frame = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: widget.size == NativeAdSize.small ? _CompactBones(bone: bone) : _FullBones(bone: bone),
    );

    // Users who've asked the OS to reduce motion get the bones without the
    // sweep — a looping animation in a slot that may resolve to nothing is
    // exactly the kind of ambient movement that setting exists to stop.
    if (MediaQuery.maybeDisableAnimationsOf(context) ?? false) return frame;

    return AnimatedBuilder(
      animation: _sweep,
      builder: (context, child) {
        final t = _sweep.value * 3 - 1.5;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment(t - 0.5, -0.3),
            end: Alignment(t + 0.5, 0.3),
            colors: [bone, highlight, bone],
          ).createShader(bounds),
          child: child,
        );
      },
      child: frame,
    );
  }
}

/// Bones for [TemplateType.medium]: icon row, media well, two body lines, CTA.
class _FullBones extends StatelessWidget {
  const _FullBones({required this.bone});

  final Color bone;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _Bone(bone: bone, width: 40, height: 40, radius: 10),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Bone(bone: bone, widthFactor: 0.62, height: 12),
                  const SizedBox(height: 7),
                  _Bone(bone: bone, widthFactor: 0.34, height: 10),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(child: _Bone(bone: bone, widthFactor: 1, height: null, radius: 8)),
        const SizedBox(height: 12),
        _Bone(bone: bone, widthFactor: 1, height: 10),
        const SizedBox(height: 7),
        _Bone(bone: bone, widthFactor: 0.75, height: 10),
        const SizedBox(height: 14),
        _Bone(bone: bone, widthFactor: 1, height: 38, radius: 8),
      ],
    );
  }
}

/// Bones for [TemplateType.small]: icon, stacked text, trailing CTA.
class _CompactBones extends StatelessWidget {
  const _CompactBones({required this.bone});

  final Color bone;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Bone(bone: bone, width: 48, height: 48, radius: 10),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Bone(bone: bone, widthFactor: 0.7, height: 11),
              const SizedBox(height: 7),
              _Bone(bone: bone, widthFactor: 0.95, height: 9),
              const SizedBox(height: 5),
              _Bone(bone: bone, widthFactor: 0.5, height: 9),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _Bone(bone: bone, width: 68, height: 30, radius: 8),
      ],
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({required this.bone, this.width, this.widthFactor, this.height, this.radius = 4});

  final Color bone;
  final double? width;
  final double? widthFactor;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final shape = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: bone, borderRadius: BorderRadius.circular(radius)),
    );
    if (widthFactor == null) return shape;
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: SizedBox(height: height, child: shape),
    );
  }
}
