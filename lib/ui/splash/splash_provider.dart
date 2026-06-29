part of 'splash.dart';

final class SplashProvider extends BaseProvider {
  final NewsRepository newsRepository;
  final ConfigRepository configRepository;
  final LoadingDialogHandler loadingDialogHandler;

  SplashProvider({
    required super.context,
    required this.newsRepository,
    required this.loadingDialogHandler,
    required this.configRepository,
  });

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    if (context.mounted) {
      ConnectivityHelper.instance.initialize(context);
    }
    await ConnectivityHelper.instance.waitForInternet();
    await Future.wait([_getWithdrawConfig(), _getCoinsConfig()]);
    changeScreen();
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

  Future<void> changeScreen() async {
    final result = await processApi(
      request: () async {
        return await newsRepository.getNewsFromApi();
      },
    );
    if (result != null && context.mounted) {
      if (preference.isShowOnBoarding) {
        context.navigator.pushNamedAndRemoveUntil(OnboardingScreen.routeName, (route) => false);
      } else if (preference.isLogin) {
        context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
      } else {
        context.navigator.pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
      }
    }
  }
}
