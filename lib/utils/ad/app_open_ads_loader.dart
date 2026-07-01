part of 'ads.dart';

class AppOpenAdsLoader extends BaseAdLoader<AppOpenAd> {
  OnAdLoaded? onAdLoaded;
  OnAdFailed? onAdFailed;
  OnAdDismissed? onAdDismissed;
  OnAdShown? onAdShown;

  @override
  AdType get adType => .appOpen;

  @override
  void disposeAdObject(AppOpenAd? ad) => ad?.dispose();

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    AppOpenAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _wireCallbacks(ad);
          onLoaded(ad, unitId);
          onAdLoaded?.call(unitId);
        },
        onAdFailedToLoad: (error) => onFailed(unitId, error.message),
      ),
    );
  }

  Future<bool> show() async {
    if (!isLoaded || ad == null) {
      Log.error('${adType.name.toUpperCase()} Not loaded — cannot show.');
      return false;
    }

    final currentAd = ad!;
    _ad = null;
    _state = AdLoadState.idle;

    Log.success('${adType.name.toUpperCase()} Showing ad..');

    await currentAd.show();

    return true;
  }

  void _wireCallbacks(AppOpenAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        onAdShown?.call();
        Log.debug('${adType.name.toUpperCase()} Showing full screen.');
      },
      onAdDismissedFullScreenContent: (_) {
        Log.debug('${adType.name.toUpperCase()} Dismissed.');
        ad.dispose();
        onAdDismissed?.call();
        _schedulePreload();
      },
      onAdFailedToShowFullScreenContent: (_, error) {
        Log.error('${adType.name.toUpperCase()} Failed to show: ${error.message}');
        ad.dispose();
        onAdFailed?.call(error.message);
        _schedulePreload();
      },
      onAdImpression: (_) => Log.success('${adType.name.toUpperCase()} Impression recorded.'),
    );
  }

  void _schedulePreload() {
    Future.delayed(2.seconds, () {
      if (!isLoaded && !isLoading) load();
    });
  }
}
