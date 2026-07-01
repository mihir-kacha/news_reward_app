part of 'ads.dart';

class RewardAdsLoader extends BaseAdLoader<RewardedAd> {
  OnAdLoaded? onAdLoaded;
  OnAdFailed? onAdFailed;
  OnAdDismissed? onAdDismissed;
  OnAdShown? onAdShown;
  OnRewardEarned? onRewardEarned;

  @override
  AdType get adType => AdType.rewarded;

  @override
  Future<void> loadAdFroUnit(String unitId) async {
    RewardedAd.load(
      adUnitId: unitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _wireCallbacks(ad);
          onLoaded(ad, unitId);
          onAdLoaded?.call(unitId);
        },
        onAdFailedToLoad: (error) => onFailed(unitId, error.message),
      ),
    );
  }

  @override
  void disposeAdObject(RewardedAd? ad) => ad?.dispose();

  Future<bool> show() async {
    if (!isLoaded || ad == null) {
      Log.error('${adType.name.toUpperCase()} Not loaded — cannot show.');
      return false;
    }

    final currentAd = ad!;
    _ad = null;
    _state = AdLoadState.idle;

    Log.success('${adType.name.toUpperCase()} Showing ad..');

    await currentAd.show(
      onUserEarnedReward: (_, rewardItem) {
        final reward = AdReward(type: rewardItem.type, amount: rewardItem.amount);
        Log.success('${adType.name.toUpperCase()} Reward earned: $reward');
        onRewardEarned?.call(reward);
      },
    );

    return true;
  }

  void _wireCallbacks(RewardedAd ad) {
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        onAdShown?.call();
        Log.debug('${adType.name.toUpperCase()} Showing full screen.');
      },
      onAdDismissedFullScreenContent: (_) {
        Log.debug('${adType.name.toUpperCase()} Dismissed.');
        ad.dispose();
        onAdDismissed?.call();
        // _schedulePreload();
      },
      onAdFailedToShowFullScreenContent: (_, error) {
        Log.error('${adType.name.toUpperCase()} Failed to show: ${error.message}');
        ad.dispose();
        onAdFailed?.call(error.message);
        // _schedulePreload();
      },
      onAdImpression: (_) => Log.success('${adType.name.toUpperCase()} Impression recorded.'),
    );
  }
}
