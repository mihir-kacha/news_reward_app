part of 'news_detail.dart';

final class NewsDetailProvider extends BaseProvider {
  final NewsData newsData;

  NewsDetailProvider({required super.context, required this.newsData});

  @override
  void initState() {
    super.initState();
    resolveAdUnitId(
      slot: NativeAdTyped.detail,
      isThisAdPlaceEnable: preference.adsConfig?.adPlaceConfig?.newsDetailAd ?? false,
    );
  }

  Future<void> showNews() async {
    await CommonFunc.openUrl(url: newsData.webLink ?? AppConstants.privacyPolicyUrl);
    await Future.delayed(200.milliseconds);
    NavigationAdHelper.instance.navigate(
      onComplete: () {
        context.navigator.pushNamed(NewsCodeScreen.routeName, arguments: newsData);
      },
    );
  }
}
