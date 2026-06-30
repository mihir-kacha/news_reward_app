part of '../onboarding.dart';

class _OnboardingTwo extends StatelessWidget {
  const _OnboardingTwo();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Assets.images.imgOn2.image(),
          Gap(Spacing.normal),
          RichText(
            text: TextSpan(
              text: "Read Daily. ",
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
              children: [
                TextSpan(
                  text: "Earn Daily",
                  style: context.textTheme.headlineMedium?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          Gap(Spacing.xSmall),
          Text(
            "No Task, no stress. Just read news and earn rewards.",
            style: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.surfaceTint,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(Spacing.large),
          _PointBullet(icons: Assets.icons.onBoarding.icNote.path, text: "Browse latest news and stay updated."),
          Gap(Spacing.small),
          _PointBullet(icons: Assets.icons.onBoarding.icCoins.path, text: "Read daily and earn reward coin."),
          Gap(Spacing.small),
          _PointBullet(icons: Assets.icons.icGift.path, text: "Redeem coins for amazing rewards"),
        ],
      ),
    );
  }
}
