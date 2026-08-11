part of 'news_detail.dart';

final class NewsDetailProvider extends BaseProvider {
  final NewsData newsData;

  NewsDetailProvider({required super.context, required this.newsData});

  @override
  void initState() {
    super.initState();
    Log.debug("Web link ===> ${newsData.webLink}");
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.newsDetailAd ?? false,
    );
  }

  bool isAdShown = false;
  bool isURLOpened = false;

  Future<void> showNews() async {
    await loadAppOpenAd();
    Log.success(newsData.webLink);
    if (newsData.webLink == null) {
      context.showErrorMessage(title: "News Url not available");
      return;
    }
    await CommonFunc.openUrl(url: newsData.webLink ?? '');
    await Future.delayed(200.milliseconds);
    context.navigator.pushNamed(NewsCodeScreen.routeName, arguments: newsData);
  }

  Future<void> loadAppOpenAd() async {
    if (isAdShown) return;
    Log.debug("loadAd");
    if (preference.adsConfig?.adsStatusModel?.isOpenAppAdShow ?? false) {
      await AdHelper.instance.loadAppOpen();
    }
  }

  Future<void> showAppOpenAd() async {
    if (isAdShown) return;
    Log.debug("shownAd");
    AdHelper.instance.setAppOpenCallbacks(
      onDismissed: () {
        isAdShown = false;
      },
      onFailed: (_) {},
      onShown: () {
        isAdShown = true;
      },
    );
    await AdHelper.instance.showAppOpen();
  }
}
