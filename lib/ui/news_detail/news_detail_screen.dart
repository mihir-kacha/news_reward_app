part of 'news_detail.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key});

  static const String routeName = '/news_screen';

  static Widget builder(BuildContext context) {
    final newsData = context.args;
    return ChangeNotifierProvider(
      create: (context) => NewsDetailProvider(context: context, newsData: newsData),
      child: NewsDetailScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsDetailProvider>();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: Spacing.normal),
        child: FilledButton(
          style: FilledButton.styleFrom(fixedSize: Size.fromWidth(context.width)),
          onPressed: provider.showNews,
          child: Text(
            "Open News to Earn 300 Points",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      appBar: NewsPayAppbar(title: Text("NewsPay")),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<NewsDetailProvider>();
    final news = provider.newsData;

    final nativeAdUnitId = context.select<NewsDetailProvider, String?>((value) => value.nativeAdUnitId);
    final adLoad = context.select<NewsDetailProvider, bool>((value) => value.adLoad);
    if (adLoad) return LoadingIndicator();
    return SingleChildScrollView(
      padding:
          EdgeInsets.all(Spacing.normal) + EdgeInsets.only(bottom: kBottomNavigationBarHeight + context.padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.medium),
            decoration: BoxDecoration(
              color: context.colorScheme.onPrimary,
              borderRadius: ShapeBorderRadius.normal,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withColorOpacity(.08),
                  spreadRadius: 0,
                  offset: Offset(0, 2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Stack(
                    children: [
                      NetworkImageBuilder(
                        height: 160,
                        width: context.width,
                        url: news.imageUrl,
                        radius: ShapeBorderRadius.medium,
                        boxFit: BoxFit.cover,
                        placeholderBuilder: (context) {
                          return Container(
                            color: context.colorScheme.primary.withColorOpacity(.03),
                            child: Center(child: Icon(Icons.newspaper)),
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Container(
                          width: context.width,
                          padding: EdgeInsets.all(Spacing.small),
                          decoration: BoxDecoration(
                            color: context.colorScheme.shadow.withColorOpacity(.8),
                            borderRadius: BorderRadius.only(
                              bottomRight: RadiusValues.medium,
                              bottomLeft: RadiusValues.medium,
                            ),
                          ),
                          child: Text(
                            news.title ?? "",
                            style: context.textTheme.labelSmall?.copyWith(
                              color: context.colorScheme.onPrimary,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(Spacing.normal),
                Text(
                  news.description ?? "",
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.surfaceTint,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(Spacing.normal),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.medium),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary.withColorOpacity(.08),
                    borderRadius: ShapeBorderRadius.medium,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.images.imgCoin.image(height: 30, width: 30),
                      Gap(Spacing.normal),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "TOTAL REWARD",
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.surfaceTint,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap(Spacing.xSmall),
                            Text(
                              "300 Points",
                              style: context.textTheme.titleLarge?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(Spacing.large),
          NativeAdComponent(adUnitId: nativeAdUnitId, detailLayout: .buttonTop, nativeAdType: .detail),
          Gap(Spacing.large),
          Text(
            "Steps to earn 300 Points :",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.shadow,
              fontWeight: FontWeight.w700,
            ),
          ),
          Gap(Spacing.small),
          Text(
            "1. Read full news in browser.",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(Spacing.xSmall),
          Text(
            "2. Find the 4-digit code at the end of the news article.",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(Spacing.xSmall),
          Text(
            "3. Enter code to collect 300 Points.",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.tertiary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
