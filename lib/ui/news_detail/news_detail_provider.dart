part of 'news_detail.dart';

final class NewsDetailProvider extends BaseProvider {
  final NewsData newsData;

  NewsDetailProvider({required super.context, required this.newsData});

  Future<void> showNews() async {
    await CommonFunc.openUrl(url: newsData.link ?? AppConstants.privacyPolicyUrl);
    await Future.delayed(200.milliseconds);
    context.navigator.pushNamed(NewsCodeScreen.routeName, arguments: newsData);
  }
}
