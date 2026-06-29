part of 'tips.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  static const String routeName = '/tips';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TipsProvider(context: context),
      child: TipsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surfaceContainerLow,
      appBar: NewsPayAppbar(title: Text("Refer & Earn"), autoLeading: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: Spacing.normal, vertical: Spacing.large),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _HintCell(
              title: "How This \nApplication \nWorks",
              image: Assets.images.imgApplicationWork.path,
              colors: [Color(0XFF0789d8), Color(0XFF02c1db)],
            ),
            Gap(Spacing.medium),
            _HintCell(
              image: Assets.images.imgTips.path,
              title: "Tips to Make \nMaximum Money",
              colors: [context.colorScheme.primary, context.colorScheme.secondary],
            ),
          ],
        ),
      ),
    );
  }
}

class _HintCell extends StatelessWidget {
  final String image;
  final String title;
  final List<Color> colors;

  const _HintCell({required this.image, required this.title, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: colors, end: Alignment.centerRight, begin: Alignment.centerLeft),
        borderRadius: ShapeBorderRadius.medium,
      ),
      child: Row(
        children: [
          Image.asset(image, width: 100),
          Gap(Spacing.xLarge),
          Text(title, style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.onPrimary)),
        ],
      ),
    );
  }
}
