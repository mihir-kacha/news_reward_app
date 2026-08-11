part of 'how_it_works.dart';

class HowItWorksScreen extends StatelessWidget {
  const HowItWorksScreen({super.key});

  static const String routeName = '/how_it_works';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HowItWorksProvider(context: context),
      child: HowItWorksScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<HowItWorksProvider>();
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      floatingActionButtonLocation: .centerFloat,
      floatingActionButton: Padding(
        padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
        child: FilledButton(
          onPressed: provider._changeScreen,
          style: FilledButton.styleFrom(fixedSize: Size.fromWidth(context.width)),
          child: Text(
            "Get Started",
            style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.only(top: context.padding.top),
        child: Column(
          children: [
            Assets.images.imgHowItWorks.image(),
            Gap(Spacing.normal),
            Text("How it works", style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.primary)),
            Gap(Spacing.small),
            Text(
              "Start earning points in simple 4 steps by reading news articles and verifying your participation.",
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.tertiary),
              textAlign: .center,
            ),
            Gap(Spacing.normal),
            _InfoCell(
              icon: Assets.icons.icNews.path,
              color: Colors.blueAccent,
              info:
                  "Choose a News Articles Brows available news stories and read the summery before opening the full articles",
            ),
            Gap(Spacing.normal),
            _InfoCell(
              icon: Assets.icons.profile.icPrivacy.path,
              color: Colors.deepPurple,
              info:
                  "read & Enter Verification code open the articles in your browns, find the 4-digit code shown at last and enter in app again.",
            ),
            Gap(Spacing.normal),
            _InfoCell(
              icon: Assets.icons.icGift.path,
              color: Colors.green,
              info:
                  "Redeem available rewards once eligibility requirements are met, redeem available rewards to your transfer id.",
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  final String icon;
  final Color color;
  final String info;

  const _InfoCell({required this.icon, required this.color, required this.info});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
      child: Container(
        padding: EdgeInsets.all(Spacing.medium),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: ShapeBorderRadius.medium,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withColorOpacity(.1),
              offset: Offset(2, 2),
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                shape: .circle,
                gradient: LinearGradient(
                  colors: [color.withColorOpacity(.3), color, color.withColorOpacity(.3)],
                  begin: .topLeft,
                  end: .bottomRight,
                ),
              ),
              child: SvgPicture.asset(
                icon,
                height: 20,
                width: 20,
                colorFilter: ColorFilter.mode(context.colorScheme.onPrimary, .srcIn),
              ),
            ),
            Gap(Spacing.medium),
            Expanded(
              child: Text(
                info,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
