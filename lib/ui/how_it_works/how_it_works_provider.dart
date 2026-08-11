part of 'how_it_works.dart';

final class HowItWorksProvider extends BaseProvider {
  HowItWorksProvider({required super.context});

  bool isAdLoading = true;
  bool isAdLoaded = false;

  Future<void> onGetStarted() async {
    if (preference.adsConfig?.adsStatusModel?.showAdsInApp ?? false) {
      await AdHelper.instance.initialized();
      if (preference.adsConfig?.adPlaceConfig?.openInterOnInitial ?? false) {
        AdHelper.instance.loadInterstitial().then((_) async {
          isAdLoaded = true;
          await _showInterAd();
        });
      }
    }
  }

  Future<void> _showInterAd() async {
    if (isAdLoading) {
      AdHelper.instance.setInterstitialCallbacks(onDismissed: _changeScreen, onFailed: (_) => _changeScreen());
      await AdHelper.instance.showInterstitial(onAdClosed: _changeScreen);
      return;
    }

    isAdLoading = false;
    notifyListeners();
    _changeScreen();
  }

  Future<void> _changeScreen() async {
    NavigationAdHelper.instance.navigate(
      onComplete: () {
        context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      },
      isHowItWorks: true,
    );
  }
}
