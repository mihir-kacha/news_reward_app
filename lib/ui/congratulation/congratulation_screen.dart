part of 'congratulation.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({super.key});

  static const String routeName = '/congratulation';

  static Widget builder(BuildContext context) {
    final oldCoins = context.args;
    return ChangeNotifierProvider(
      create: (context) =>
          CongratulationProvider(context: context, newsRepository: NewsRepository(), oldCoins: oldCoins),
      child: CongratulationScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.navigator.pushNamedAndRemoveUntil(DashboardScreen.routeName, (route) => false);
      },
      child: Scaffold(
        backgroundColor: context.colorScheme.onPrimary,
        appBar: NewsPayAppbar(title: SizedBox(), showBack: false),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CongratulationProvider>();
    final nativeAdUnitId = context.select<CongratulationProvider, String?>((value) => value.nativeAdUnitId);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Assets.images.imgTrofee.image(height: 100, width: 100)),
              Gap(Spacing.small),
              Text(
                "Congratulation!",
                style: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.shadow),
              ),
              Gap(Spacing.normal),
              Container(
                padding: EdgeInsets.all(Spacing.normal),
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: ShapeBorderRadius.medium,
                  boxShadow: [
                    BoxShadow(
                      color: context.colorScheme.shadow.withColorOpacity(.08),
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Success! You've earned 300 rewards.",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.shadow,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gap(Spacing.small),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.images.imgConfetti.image(height: 16, width: 16),
                        Gap(Spacing.small),
                        Text(
                          "300 Points Added to Wallet!",
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.surfaceTint,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gap(Spacing.xSmall),
                    RichText(
                      text: TextSpan(
                        text: "Wallet Balance : ${provider.oldCoins} ",
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.surfaceTint,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: "\u2192 ${Preference().userInfo.coins}",
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.w600,
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
          Gap(Spacing.normal),
          NativeAdComponent(adUnitId: nativeAdUnitId, nativeAdType: .detail),
          Gap(Spacing.small),
          // Expanded(child: _News()),
          _News(),
        ],
      ),
    );
  }
}

class _News extends StatelessWidget {
  const _News();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<CongratulationProvider>();
    final list = context.select<CongratulationProvider, List<NewsData>>((value) => value.list);
    final isLoading = context.select<CongratulationProvider, bool>((value) => value.loading);
    if (provider.list.isEmpty) {
      if (isLoading) {
        return Center(child: LoadingIndicator());
      }
      return SizedBox();
    }
    return PaginationListener(
      onRefresh: (context) => provider.onRefresh(),
      onScrollToEnd: (context) => provider.onLoadMore(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: list.length,
        itemBuilder: (context, index) {
          final newsData = list[index];
          return NewsCell(newsData: newsData);
        },
      ),
    );
  }
}
