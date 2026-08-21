part of 'news.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  static const String routeName = '/news';

  static Widget builder(BuildContext context) {
    final category = context.args as Category;
    return ChangeNotifierProvider(
      create: (context) => NewsProvider(
        context: context,
        category: category,
        newsRepository: NewsRepository(),
        loadingDialogHandler: LoadingDialogHandler(context: context),
      ),
      child: NewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsProvider>();
    return Scaffold(
      appBar: NewsPayAppbar(title: Text(provider.category.label)),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsProvider>();
    final list = context.select<NewsProvider, List<NewsData>>((value) => value.list);
    final isLoading = context.select<NewsProvider, bool>((value) => value.loading || value.adLoad);
    final nativeAdUnitId = context.select<NewsProvider, String?>((value) => value.nativeAdUnitId);
    if (provider.list.isEmpty) {
      if (isLoading) {
        return Center(child: LoadingIndicator());
      }
      return Center(
        child: Text(
          "No news for ${provider.category.name}",
          style: context.textTheme.headlineSmall?.copyWith(color: provider.category.color),
        ),
      );
    }
    return PaginationListener(
      onRefresh: (context) => provider.onRefresh(),
      onScrollToEnd: (context) => provider.onLoadMore(),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(vertical: Spacing.normal),
        physics: AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final newsData = list[index];
          if (index == 0) {
            return AdManagerNativeAd(
              adUnitId: Preference().adsIds?.nativeAdsIds?.firstOrNull ?? "",
              isShowAd: Preference().adsConfig?.adPlaceConfig?.categoryNewsAd ?? false,
            );
          }
          return NewsCell(newsData: newsData);
        },
      ),
    );
  }
}
