part of 'verify.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  static const String routeName = '/verify';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VerifyProvider(context: context),
      child: VerifyScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.colorScheme.onPrimary, body: _BoardingSecond());
  }
}

class _BoardingSecond extends StatelessWidget {
  const _BoardingSecond();

  @override
  Widget build(BuildContext context) {
    final nativeAdUnitId = context.select<VerifyProvider, String?>((value) => value.nativeAdUnitId);

    return Padding(
      padding: EdgeInsetsGeometry.only(top: context.padding.top),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Assets.images.imgBoardingSecond.image(),
                  Gap(Spacing.normal),
                  Text(
                    "verify & Earn Points",
                    style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.primary),
                  ),
                  Gap(Spacing.small),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Spacing.normal),
                    child: Text(
                      "After reading an articles, enter 4-digit verification code displayed on the page. Confirm your participation and collect reward points for engaging with content",
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
            padding:
                EdgeInsets.symmetric(horizontal: Spacing.normal) +
                EdgeInsets.only(bottom: context.padding.bottom + Spacing.normal),
            child: FilledButton(
              style: FilledButton.styleFrom(fixedSize: Size.fromWidth(context.width)),
              onPressed: () {
                context.navigator.pushNamedAndRemoveUntil(HowItWorksScreen.routeName, (route) => false);
                Preference().isShowOnBoarding = false;
              },
              child: Text("Next", style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary)),
            ),
          ),
        ],
      ),
    );
  }
}
