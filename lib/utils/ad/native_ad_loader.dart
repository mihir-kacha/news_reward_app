part of 'ads.dart';

class NativeAdLoader extends BaseAdLoader<NativeAd> {
  final NativeAdTyped slot;

  NativeAdLoader({this.slot = .feed});

  OnNativeAdLoaded? onNativeAdLoaded;
  OnAdFailed? onAdFailed;

  final ValueNotifier<AdLoadState> stateNotifier = ValueNotifier(AdLoadState.idle);

  @override
  AdType get adType => .native;

  @override
  void disposeAdObject(NativeAd? ad) {
    stateNotifier.value = .disposed;
    ad?.dispose();
  }

  Widget? buildWidget({double height = 120.0}) {
    if (!isLoaded || ad == null) return null;
    return SizedBox(
      height: height,
      child: AdWidget(ad: ad!),
    );
  }

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    final nativeAd = NativeAd(
      adUnitId: unitId,
      request: const AdRequest(),
      nativeTemplateStyle: templateStyle,
      nativeAdOptions: adOptions,
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          stateNotifier.value = AdLoadState.loaded;
          onLoaded(ad as NativeAd, unitId);
          onNativeAdLoaded?.call(ad, unitId);
        },
        onAdFailedToLoad: (ad, error) {
          stateNotifier.value = AdLoadState.failed;
          ad.dispose();
          onFailed(unitId, error.message);
        },
        onAdOpened: (_) => Log.debug('Native[${slot.name}] Opened.'),
        onAdClosed: (_) => Log.debug('Native[${slot.name}] Closed.'),
        onAdImpression: (_) {
          Log.success('Native[${slot.name}] Impression recorded.');
          Future.microtask(() {
            load();
          });
        },
        onAdClicked: (_) => Log.debug('Native[${slot.name}] Clicked.'),
      ),
    );
    await nativeAd.load();
  }

  NativeAdOptions get adOptions => switch (slot) {
    .nativeVideo => NativeAdOptions(
      adChoicesPlacement: AdChoicesPlacement.topRightCorner,
      mediaAspectRatio: MediaAspectRatio.landscape,
      videoOptions: VideoOptions(clickToExpandRequested: true, customControlsRequested: true, startMuted: true),
      requestCustomMuteThisAd: false,
      shouldRequestMultipleImages: false,
    ),
    _ => NativeAdOptions(
      adChoicesPlacement: AdChoicesPlacement.topRightCorner,
      mediaAspectRatio: MediaAspectRatio.any,
      videoOptions: VideoOptions(clickToExpandRequested: false, customControlsRequested: false, startMuted: true),
      requestCustomMuteThisAd: false,
      shouldRequestMultipleImages: false,
    ),
  };

  NativeTemplateStyle get templateStyle => switch (slot) {
    .nativeVideo => NativeTemplateStyle(
      templateType: .medium,
      mainBackgroundColor: Colors.white,
      cornerRadius: 16,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: Color(0xFF1FB255),
        style: NativeTemplateFontStyle.bold,
        size: 16,
      ),
      primaryTextStyle: NativeTemplateTextStyle(
        textColor: const Color(0xFF000000),
        style: NativeTemplateFontStyle.bold,
        size: 16.0,
      ),
      secondaryTextStyle: NativeTemplateTextStyle(textColor: const Color(0xFF7C7C7C), size: 14.0),
      tertiaryTextStyle: NativeTemplateTextStyle(textColor: const Color(0xFF6B7280), size: 12.0),
    ),
    _ => NativeTemplateStyle(
      templateType: slot == .feed ? TemplateType.small : TemplateType.medium,
      mainBackgroundColor: Colors.white,
      cornerRadius: 16.0,
      callToActionTextStyle: NativeTemplateTextStyle(
        textColor: Colors.white,
        backgroundColor: const Color(0xFF1FB255),
        style: NativeTemplateFontStyle.bold,
        size: 14.0,
      ),

      primaryTextStyle: NativeTemplateTextStyle(
        textColor: const Color(0xFF000000),
        style: NativeTemplateFontStyle.bold,
        size: 15.0,
      ),

      secondaryTextStyle: NativeTemplateTextStyle(textColor: const Color(0xFF7C7C7C), size: 13.0),

      tertiaryTextStyle: NativeTemplateTextStyle(textColor: const Color(0xFF94969C), size: 12.0),
    ),
  };
}
