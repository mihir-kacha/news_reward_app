part of 'splash.dart';

final class SplashProvider extends BaseProvider {
  final NewsRepository newsRepository;
  final ConfigRepository configRepository;
  final AdRepository adsRepository;
  final UserRepository userRepository;

  SplashProvider({
    required super.context,
    required this.newsRepository,
    required this.configRepository,
    required this.adsRepository,
    required this.userRepository,
  });

  bool isAdLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    tz.initializeTimeZones();
    print("initializeTimeZones");
    final TimezoneInfo timezoneInfo = await FlutterTimezone.getLocalTimezone();
    print("timezoneInfo");
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    print("setLocalLocation");
    await NotificationHelper.instance.initialize();
    print("NotificationHelper");
    if (context.mounted) {
      ConnectivityHelper.instance.initialize(context);
    }
    await ConnectivityHelper.instance.waitForInternet();
    _fetchAppConfigs();
  }

  Future<void> _fetchAppConfigs() async {
    print("object");
    await _getWithdrawConfig();
    await _getCoinsConfig();
    await _getReferralCoinsConfig();
    await _getAdsConfig();
    await _getUserInfo();
  }

  Future<void> _getWithdrawConfig() async {
    final result = await processApi(
      request: () async {
        return await configRepository.getWithdrawConfig();
      },
    );
    if (result != null) {
      preference.coins = result.coins;
      preference.minCoins = result.minCoins;
      notifyListeners();
    }
  }

  Future<void> _getCoinsConfig() async {
    final result = await processApi(
      request: () async {
        return await configRepository.getCoinConfig();
      },
    );
    if (result != null) {
      preference.coinsConfig = result;
      notifyListeners();
    }
  }

  Future<void> _getReferralCoinsConfig() async {
    final result = await processApi(
      request: () async {
        return await configRepository.getReferralCoinConfig();
      },
    );
    if (result != null) {
      preference.referralCoinsConfig = result;
      notifyListeners();
    }
  }

  Future<void> _getAdsConfig() async {
    print("0");
    final adsConfig = await adsRepository.getAdsConfig();
    preference.adsConfig = adsConfig;
    print("1");

    final adsIds = await adsRepository.getAdsIds();
    preference.adsIds = adsIds;
    print("2");
    _changeScreen();
    return;
    if (preference.adsConfig?.adsStatusModel?.showAdsInApp ?? false) {
      print("3");
      await AdHelper.instance.initialized();
      print("4");
      if (preference.adsConfig?.adsStatusModel?.isOpenAppAdShow ?? false) {
        final result = await AdHelper.instance.loadAppOpen();
        print("5");
        if (result.success) {
          print("6");
          AdHelper.instance.setAppOpenCallbacks(onDismissed: _changeScreen, onFailed: (_) => _changeScreen());
          print("7");
          await AdHelper.instance.showAppOpen();
          return;
        } else {
          _changeScreen();
          print("8");
        }
      }
    }

    isAdLoading = false;
    notifyListeners();
    // _changeScreen();
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

  Future<void> _getUserInfo() async {
    final result = await processApi(
      request: () async {
        return await userRepository.getUserDetails();
      },
    );
    if (result != null) {
      preference.userInfo = result.toGeneralInfo();
      notifyListeners();
    }
  }

  Future<void> _changeScreen() async {
    // final result = await processApi(
    //   request: () async {
    //     return await newsRepository.getNewsFromApi();
    //   },
    // );
    // if (result != null && context.mounted) {
    if (preference.isShowOnBoarding) {
      context.navigator.pushNamedAndRemoveUntil(ReadNewsScreen.routeName, (route) => false);
    } else if (preference.isLogin) {
      context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
    } else {
      context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
    // }
  }
}
