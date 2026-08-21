import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// Google's Ad Manager sample adaptive banner unit. Returns test creatives for
/// every request and isn't tied to your network, so it can't generate invalid
/// traffic. Used automatically in debug builds unless [useTestAdInDebug] is off.
const String kAdManagerBannerTestUnit = '/21775744923/example/adaptive-banner';

/// Where the banner sits, which determines how its size is calculated.
enum BannerPlacement {
  /// Pinned to the top or bottom of the screen. Fixed aspect ratio, capped at
  /// 150dp or 20% of screen height — whichever is smaller.
  anchored,

  /// Inside scrolling content. Variable height, taller creatives allowed,
  /// generally the better earner where the layout can absorb the height.
  inline,
}

/// A drop-in adaptive banner slot for Google Ad Manager.
///
/// Measures its own container, resolves the right adaptive size, loads, retries,
/// reloads on rotation, and disposes itself.
///
/// ```dart
/// BannerAdSlot(
///   adUnitId: '/123456789/myapp_android/android_banner_home_anchor',
/// )
/// ```
///
/// Requires `MobileAds.instance.initialize()` to have been awaited in `main()`.
class AdManagerBannerAdSlot extends StatefulWidget {
  const AdManagerBannerAdSlot({
    super.key,
    required this.adUnitId,
    this.placement = BannerPlacement.anchored,
    this.maxInlineHeight,
    this.extraSizes = const [],
    this.customTargeting,
    this.padding = EdgeInsets.zero,
    this.maxRetries = 3,
    this.retryBaseDelay = const Duration(seconds: 4),
    this.reserveSpaceWhileLoading = true,
    this.collapseOnFailure = true,
    this.useTestAdInDebug = true,
    this.loadingBuilder,
    this.onLoaded,
    this.onFailed,
    this.onRevenue,
  });

  /// Full Ad Manager path, e.g. `/123456789/myapp_android/android_banner_home`.
  final String adUnitId;

  final BannerPlacement placement;

  /// Caps height for [BannerPlacement.inline]. Leave null to let the creative
  /// choose. Setting a limit can reduce fill and eCPM.
  final int? maxInlineHeight;

  /// Additional fixed sizes allowed to compete for this slot alongside the
  /// adaptive size. Ad Manager only — AdMob accepts a single size.
  final List<AdSize> extraSizes;

  /// Ad Manager key-values sent with the request.
  final Map<String, String>? customTargeting;

  final EdgeInsets padding;

  /// Attempts after the first failure. Set to 0 to never retry.
  final int maxRetries;

  /// Delay before the first retry. Doubles on each subsequent attempt.
  final Duration retryBaseDelay;

  /// Hold the slot open at the resolved height while the request is in flight,
  /// so surrounding content doesn't jump when the ad arrives.
  final bool reserveSpaceWhileLoading;

  /// Take up zero space once retries are exhausted rather than leaving a gap.
  final bool collapseOnFailure;

  /// Swap [adUnitId] for [kAdManagerBannerTestUnit] in debug builds.
  final bool useTestAdInDebug;

  final WidgetBuilder? loadingBuilder;

  final VoidCallback? onLoaded;

  /// Receives the final error after all retries are exhausted.
  final void Function(LoadAdError error)? onFailed;

  /// Fires on each paid impression — wire to analytics for per-slot eCPM.
  final void Function(double valueMicros, String currencyCode)? onRevenue;

  @override
  State<AdManagerBannerAdSlot> createState() => _AdManagerBannerAdSlotState();
}

enum _SlotState { sizing, loading, loaded, failed }

class _AdManagerBannerAdSlotState extends State<AdManagerBannerAdSlot>
    with AutomaticKeepAliveClientMixin {
  AdManagerBannerAd? _ad;
  Timer? _retryTimer;
  _SlotState _state = _SlotState.sizing;
  AdSize? _size;
  double? _renderedHeight;
  int _attempt = 0;
  int? _lastWidth;
  Orientation? _lastOrientation;

  // Without this, scrolling the slot out of a ListView tears the banner down
  // and fires a fresh request every time it returns — which inflates request
  // counts, craters fill rate, and reads as invalid traffic.
  @override
  bool get wantKeepAlive => true;

  String get _resolvedUnitId => (kDebugMode && widget.useTestAdInDebug)
      ? kAdManagerBannerTestUnit
      : widget.adUnitId;

  double get _slotHeight =>
      _renderedHeight ?? _size?.height.toDouble() ?? _fallbackHeight;

  double get _fallbackHeight =>
      widget.placement == BannerPlacement.anchored ? 50 : 100;

  @override
  void dispose() {
    _retryTimer?.cancel();
    _ad?.dispose();
    super.dispose();
  }

  /// Rebuilds the ad when the available width or orientation changes. Adaptive
  /// sizes are orientation-specific, so a rotated banner must be re-requested
  /// rather than stretched.
  void _syncToConstraints(double maxWidth, Orientation orientation) {
    final width = maxWidth.truncate();
    if (width <= 0) return;
    if (_lastWidth == width && _lastOrientation == orientation) return;

    _lastWidth = width;
    _lastOrientation = orientation;
    _restart(width, orientation);
  }

  Future<void> _restart(int width, Orientation orientation) async {
    _retryTimer?.cancel();
    _ad?.dispose();
    _ad = null;
    _attempt = 0;
    _renderedHeight = null;
    if (mounted) setState(() => _state = _SlotState.sizing);

    final size = await _resolveSize(width, orientation);
    if (!mounted) return;

    if (size == null) {
      // No valid adaptive size for this device — nothing sensible to request.
      setState(() => _state = _SlotState.failed);
      return;
    }

    setState(() {
      _size = size;
      _state = _SlotState.loading;
    });
    _load();
  }

  Future<AdSize?> _resolveSize(int width, Orientation orientation) {
    if (widget.placement == BannerPlacement.anchored) {
      return AdSize.getLargeAnchoredAdaptiveBannerAdSizeWithOrientation(
          orientation, width);
    }
    final inline = widget.maxInlineHeight == null
        ? AdSize.getCurrentOrientationInlineAdaptiveBannerAdSize(width)
        : AdSize.getInlineAdaptiveBannerAdSize(width, widget.maxInlineHeight!);
    return Future.value(inline);
  }

  void _load() {
    final size = _size;
    if (size == null) return;

    final ad = AdManagerBannerAd(
      adUnitId: _resolvedUnitId,
      // Multiple sizes competing for one slot is an Ad Manager capability the
      // AdMob request path doesn't have. Adaptive first, fallbacks after.
      sizes: [size, ...widget.extraSizes],
      request: AdManagerAdRequest(customTargeting: widget.customTargeting),
      listener: AdManagerBannerAdListener(
        onAdLoaded: (ad) async {
          if (!mounted) {
            ad.dispose();
            return;
          }
          // Inline creatives report their real height only once rendered.
          final actual = await (ad as AdManagerBannerAd).getPlatformAdSize();
          if (!mounted) return;
          setState(() {
            _renderedHeight = actual?.height.toDouble();
            _state = _SlotState.loaded;
            _attempt = 0;
          });
          widget.onLoaded?.call();
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (!mounted) return;
          _handleFailure(error);
        },
        onPaidEvent: (_, value, __, currency) =>
            widget.onRevenue?.call(value, currency.toString()),
      ),
    );

    _ad = ad;
    ad.load();
  }

  void _handleFailure(LoadAdError error) {
    _ad = null;
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
      debugPrint('Banner gave up on $_resolvedUnitId — '
          'code ${error.code}: ${error.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final orientation = MediaQuery.orientationOf(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Deferred so the size request doesn't fire during layout.
        WidgetsBinding.instance.addPostFrameCallback(
              (_) => _syncToConstraints(constraints.maxWidth, orientation),
        );

        switch (_state) {
          case _SlotState.loaded:
            return Padding(
              padding: widget.padding,
              child: SizedBox(
                width: _size!.width.toDouble(),
                height: _slotHeight,
                child: AdWidget(ad: _ad!),
              ),
            );

          case _SlotState.failed:
            if (widget.collapseOnFailure) return const SizedBox.shrink();
            return SizedBox(height: _slotHeight);

          case _SlotState.sizing:
          case _SlotState.loading:
            if (!widget.reserveSpaceWhileLoading) return const SizedBox.shrink();
            return Padding(
              padding: widget.padding,
              child: SizedBox(
                height: _slotHeight,
                width: double.infinity,
                child: widget.loadingBuilder?.call(context) ??
                    const _BannerSkeleton(),
              ),
            );
        }
      },
    );
  }
}

/// Shimmering bar sized to the slot. Deliberately unlabelled — a "Loading ad"
/// caption promises an impression the slot may never deliver.
class _BannerSkeleton extends StatefulWidget {
  const _BannerSkeleton();

  @override
  State<_BannerSkeleton> createState() => _BannerSkeletonState();
}

class _BannerSkeletonState extends State<_BannerSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _sweep = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat();

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

    final frame = DecoratedBox(
      decoration: BoxDecoration(
        color: bone,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    // A looping sweep in a slot that may resolve to nothing is exactly the
    // ambient movement the reduce-motion setting exists to stop.
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