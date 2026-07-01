part of 'ads.dart';

class RewardedInterstitialAdsLoader extends BaseAdLoader<RewardedInterstitialAd> {
  OnAdLoaded? onAdLoaded;
  OnAdFailed? onAdFailed;
  OnAdDismissed? onAdDismissed;
  OnAdShown? onAdShown;
  OnRewardEarned? onRewardEarned;

  @override
  AdType get adType => .rewardedInterstitial;

  @override
  void disposeAdObject(RewardedInterstitialAd? ad) => ad?.dispose();

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    RewardedInterstitialAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
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
    await currentAd.show(
      onUserEarnedReward: (ad, reward) {
        Log.success('${adType.name.toUpperCase()} Reward earned : $reward');
        onRewardEarned?.call(AdReward(type: reward.type, amount: reward.amount));
      },
    );

    return true;
  }

  void _wireCallbacks(RewardedInterstitialAd ad, String unitId) {
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
      onAdImpression: (ad) => Log.success('${adType.name.toUpperCase()} Impression recoded.'),
    );
  }

  void _schedulePreload() {
    Future.delayed(2.seconds, () {
      if (!isLoaded && !isLoading) load();
    });
  }
}
