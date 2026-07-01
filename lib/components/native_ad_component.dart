import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inshorts/components/shimmer_skeleton.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/utils/ad/ads.dart';

class NativeAdComponent extends StatefulWidget {
  const NativeAdComponent({
    super.key,
    required this.adUnitId,
    this.nativeAdType = NativeAdTyped.feed,
    this.height = 324,
  });

  final String? adUnitId;
  final NativeAdTyped nativeAdType;
  final double height;

  @override
  State<NativeAdComponent> createState() => _NativeAdComponentState();
}

enum _AdState { loading, loaded, failed }

class _NativeAdComponentState extends State<NativeAdComponent> {
  MethodChannel? _channel;
  final ValueNotifier<_AdState> _adState = ValueNotifier(_AdState.loading);

  void _setupChannel(int viewId) {
    _channel = MethodChannel('native_ad_view_$viewId');
    _channel!.setMethodCallHandler((call) async {
      if (!mounted) return;
      switch (call.method) {
        case 'onAdLoaded':
          _adState.value = _AdState.loaded;
          break;
        case 'onAdFailed':
          _adState.value = _AdState.failed;
          break;
      }
    });
  }

  @override
  void dispose() {
    _channel?.setMethodCallHandler(null);
    _adState.dispose();
    // _loader?.dispose();
    super.dispose();
  }

  double get _resolvedHeight => widget.nativeAdType == NativeAdTyped.feed ? 72.0 : widget.height;

  @override
  Widget build(BuildContext context) {
    if (widget.adUnitId == null) return const SizedBox.shrink();

    return ValueListenableBuilder<_AdState>(
      valueListenable: _adState,
      builder: (context, state, _) {
        if (state == _AdState.failed) return const SizedBox.shrink();

        return SizedBox(
          height: _resolvedHeight,
          child: Stack(
            children: [
              AndroidView(
                viewType: 'custom_native_ad_view',
                creationParams: {'adUnitId': widget.adUnitId, 'adSlot': widget.nativeAdType.name},
                creationParamsCodec: const StandardMessageCodec(),
                onPlatformViewCreated: _setupChannel,
              ),
              if (state == _AdState.loading) ...[ShimmerSkeleton(height: _resolvedHeight, width: context.width)],
            ],
          ),
        );
      },
    );
  }
}
