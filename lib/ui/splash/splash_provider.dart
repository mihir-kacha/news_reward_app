part of 'splash.dart';

final class SplashProvider extends BaseProvider {
  final NewsRepository newsRepository;
  final LoadingDialogHandler loadingDialogHandler;

  SplashProvider({required super.context, required this.newsRepository, required this.loadingDialogHandler});

  @override
  void initState() {
    super.initState();
    // changeScreen();
  }

  Future<void> changeScreen() async {
    final result = await processApi(
      request: () async {
        return await newsRepository.getNewsFromApi();
      },
      onLoading: loadingDialogHandler.handleLoading,
    );
    // await Future.delayed(Duration(seconds: 3));
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
