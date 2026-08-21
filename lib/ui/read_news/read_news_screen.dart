part of 'read_news.dart';

class ReadNewsScreen extends StatelessWidget {
  const ReadNewsScreen({super.key});

  static const String routeName = '/read_news';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ReadNewsProvider(context: context),
      child: ReadNewsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.colorScheme.onPrimary, body: _BoardingFirst());
  }
}

class _BoardingFirst extends StatelessWidget {
  const _BoardingFirst();

  @override
  Widget build(BuildContext context) {
    final nativeAdUnitId = context.select<ReadNewsProvider, String?>((value) => value.nativeAdUnitId);

    return Padding(
      padding: EdgeInsetsGeometry.only(top: context.padding.top, bottom: context.padding.bottom + Spacing.normal),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Assets.images.imgBoardingFirst.image(),
                  Gap(Spacing.normal),
                  Text(
                    "Read News & Stay Updated",
                    style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.primary),
                  ),
                  Gap(Spacing.small),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
                    child: Text(
                      "Brows short news summaries and open full articles from trusted public source. stay informs about trending stories, current events, technology, business, sports and many more.",
                      style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.tertiary),
                      textAlign: .center,
                    ),
                  ),
                  Gap(Spacing.small),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
            child: FilledButton(
              style: FilledButton.styleFrom(fixedSize: Size.fromWidth(context.width)),
              onPressed: () {
                context.navigator.pushNamedAndRemoveUntil(VerifyScreen.routeName, (route) => false);
              },
              child: Text("Next", style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}
