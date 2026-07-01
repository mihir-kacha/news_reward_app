part of 'ads.dart';

class InterstitialAdsLoader extends BaseAdLoader<InterstitialAd> {
  OnAdLoaded? onAdLoaded;
  OnAdFailed? onAdFailed;
  OnAdDismissed? onAdDismissed;
  OnAdShown? onAdShown;

  @override
  AdType get adType => .interstitial;

  @override
  void disposeAdObject(InterstitialAd? ad) async => ad?.dispose();

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    InterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _wireCallbacks(ad, unitId);
          onLoaded(ad, unitId);
          onAdLoaded?.call(unitId);
        },
        onAdFailedToLoad: (error) => onFailed(unitId, error.message),
      ),
    );
  }

  Future<bool> show() async {
    if (!isLoaded || ad == null) {
      Log.error('${adType.name.toUpperCase()} Not Loaded -- cannot show');
      return false;
    }

    final currentAd = ad!;
    _ad = null;
    _state = .idle;

    Log.success('${adType.name.toUpperCase()} Showing Ad..');
    await currentAd.show();

    return true;
  }

  void _wireCallbacks(InterstitialAd ad, String unitId) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        onAdShown?.call();
        Log.debug('${adType.name.toUpperCase()} Showing full screen.');
      },
      onAdDismissedFullScreenContent: (ad) {
        Log.debug('${adType.name.toUpperCase()} Dismissed.');
        onAdDismissed?.call();
        _schedulePreload();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        Log.debug('${adType.name.toUpperCase()} Failed to Show : ${error.message}');
        clearAd();
        onAdFailed?.call(error.message);
        _schedulePreload();
      },
    );
  }

  void _schedulePreload() {
    Future.delayed(2.seconds, () {
      if (!isLoaded && !isLoading) load();
    });
  }
}
