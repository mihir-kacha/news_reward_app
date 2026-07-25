part of 'news_code.dart';

final class NewsCodeProvider extends BaseProvider {
  final NewsData newsData;
  final UserRepository userRepository;
  final LoadingDialogHandler loadingDialogHandler;

  NewsCodeProvider({
    required super.context,
    required this.newsData,
    required this.userRepository,
    required this.loadingDialogHandler,
  });

  @override
  void initState() {
    super.initState();
    resolveAdUnitId(
      slot: NativeAdTyped.feed,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.newsCodeAd ?? false,
    );
  }

  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int oldCoins = 0;

  Future<void> showNews() async {
    if (newsData.webLink == null) {
      context.showErrorMessage(title: "News Url not available");
      return;
    }
    await CommonFunc.openUrl(url: newsData.link ?? "");
  }

  Future<void> earnCoins() async {
    oldCoins = preference.userInfo.coins;

    if ((formKey.currentState?.validate() ?? false) && context.mounted) {
      await _processReward(coins: 300);
      NavigationAdHelper.instance.navigate(
        onComplete: () {
          context.navigator.pushNamed(CongratulationScreen.routeName, arguments: oldCoins);
        },
      );
      preference.readNews = preference.readNews + 1;
      eventBus.fire(SurveyCompletedEvet());
      codeController.clear();
    }
  }

  Future<void> _processReward({required int coins}) async {
    await processApi(
      request: () async {
        return await userRepository.addCoins(coins: coins);
      },
      onLoading: (loading) {
        isLoading = loading;
        notifyListeners();
      },
    );
  }
}
