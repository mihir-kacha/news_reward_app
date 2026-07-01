part of 'onboarding.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding';

  static Widget builder(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingProvider(context: context),
      child: OnboardingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: context.colorScheme.onPrimary, appBar: _OnBoardingAppBar(), body: _Body());
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnboardingProvider>();
    final currentIndex = context.select<OnboardingProvider, int>((value) => value.currentIndex);
    return Padding(
      padding: EdgeInsetsGeometry.all(Spacing.normal),
      child: Stack(
        children: [
          PageView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 2,
            clipBehavior: Clip.hardEdge,
            scrollDirection: Axis.horizontal,
            controller: provider.pageController,
            itemBuilder: (context, index) {
              if (currentIndex == 0) {
                return _OnboardingOne();
              } else {
                return _OnboardingTwo();
              }
            },
          ),
          Positioned.fill(
            bottom: context.padding.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Gap(Spacing.large),
                Row(
                  spacing: Spacing.xSmall,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    2,
                    (i) => Container(
                      height: 6,
                      width: i == currentIndex ? 50 : 16,
                      decoration: BoxDecoration(
                        color: i == currentIndex ? context.colorScheme.primary : context.colorScheme.outline,
                        borderRadius: ShapeBorderRadius.large,
                      ),
                    ),
                  ),
                ),
                Gap(Spacing.small),
                FilledButton(
                  onPressed: () => provider.onNext(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (currentIndex == 0) ? "Get Started" : "Next",
                        style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                      ),
                      Gap(Spacing.normal),
                      Icon(Icons.arrow_forward_ios_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
