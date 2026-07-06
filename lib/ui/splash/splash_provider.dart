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
    final TimezoneInfo timezoneInfo = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    await NotificationHelper.instance.initialize();
    if (context.mounted) {
      ConnectivityHelper.instance.initialize(context);
    }
    await ConnectivityHelper.instance.waitForInternet();
    _fetchAppConfigs();
  }

  Future<void> _fetchAppConfigs() async {
    await Future.wait([
      _getWithdrawConfig(),
      _getCoinsConfig(),
      _getReferralCoinsConfig(),
      _getAdsConfig(),
      _getUserInfo(),
    ]);
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
    final adsConfig = await adsRepository.getAdsConfig();
    preference.adsConfig = adsConfig;

    final adsIds = await adsRepository.getAdsIds();
    preference.adsIds = adsIds;

    if (preference.adsConfig?.adsStatusModel?.showAdsInApp ?? false) {
      await AdHelper.instance.initialized();

      if (preference.adsConfig?.adsStatusModel?.isOpenAppAdShow ?? false) {
        final result = await AdHelper.instance.loadAppOpen();

        if (result.success) {
          AdHelper.instance.setAppOpenCallbacks(onDismissed: _changeScreen, onFailed: (_) => _changeScreen());
          await AdHelper.instance.showAppOpen();
          return;
        }
      }
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
      context.navigator.pushNamedAndRemoveUntil(OnboardingScreen.routeName, (route) => false);
    } else if (preference.isLogin) {
      context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
    } else {
      context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
    }
    // }
  }
}
