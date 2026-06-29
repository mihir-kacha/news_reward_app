part of 'login.dart';

final class LoginProvider extends BaseProvider {
  final AuthRepository authRepository;
  final LoadingHandler loadingHandler;
  final ConfigRepository configRepository;

  LoginProvider({
    required super.context,
    required this.loadingHandler,
    required this.configRepository,
    required this.authRepository,
  });

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    Future.wait([_getWithdrawConfig(), _getCoinsConfig()]);
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

  Future<void> onGoogleSignIn() async {
    final referCode = await authRepository.generateUniqueReferCode();

    final userData = await processApi(
      request: () async {
        return await authRepository.signInWithGoogle(coins: preference.userInfo.coins, referCode: referCode);
      },
      onLoading: loadingHandler.handleLoading,
    );

    _afterLogin(userData);
  }

  void _afterLogin(UserModel? userData) {
    if (userData != null && context.mounted) {
      if (context.mounted) {
        context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
      }
      preference.isLogin = true;
      preference.isShowOnBoarding = false;
      preference.userId = userData.id;
      preference.userInfo = userData.toGeneralInfo();
      preference.referCode = userData.referCode;
    }
  }
}
