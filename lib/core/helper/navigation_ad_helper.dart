part of '../core.dart';

class NavigationAdHelper {
  NavigationAdHelper._();

  static final NavigationAdHelper instance = NavigationAdHelper._();

  int navigationCount = 0;
  bool isRewardAdActive = false;

  Future<void> navigate({required VoidCallback onComplete, bool isHowItWorks = false}) async {
    if (navigatorKey.currentContext == null) {
      Log.error("navigatorKey.currentContext is null");
      return;
    }
    LoadingDialogHandler loadingDialogHandler = LoadingDialogHandler(context: navigatorKey.currentContext!);
    navigationCount++;

    final threshold = isHowItWorks ? 0 : Preference().adsConfig?.adsCountsModel?.interstitialAdsIntervalCount ?? 5;

    if (navigationCount >= threshold && !isRewardAdActive) {
      navigationCount = 0;

      loadingDialogHandler.handleLoading(
        true,
        message:
            (Preference().adsConfig?.adsStatusModel?.showAdsInApp ?? false) &&
                (Preference().adsConfig?.adsStatusModel?.isInterstitialShow ?? false)
            ? "Ad Loading"
            : "",
        showAdLoading: true,
      );

      AdLoadResult result = await AdHelper.instance.loadInterstitial();

      if (!result.success) {
        result = await AdHelper.instance.loadInterstitial();
      }

      if (result.success) {
        AdHelper.instance.showInterstitial(
          onAdClosed: () async {
            loadingDialogHandler.handleLoading(false);
            await ConnectivityHelper.instance.waitForInternet();
            onComplete();
          },
        );
      } else {
        loadingDialogHandler.handleLoading(false);
        await ConnectivityHelper.instance.waitForInternet();
        onComplete();
      }
      return;
    }

    onComplete();
  }
}
