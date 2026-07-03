part of '../onboarding.dart';

class _OnboardingOne extends StatelessWidget {
  const _OnboardingOne();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: Spacing.normal) + EdgeInsets.only(top: Spacing.normal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                text: "Read News & Earn",
                style: context.textTheme.headlineSmall?.copyWith(
                  color: context.colorScheme.shadow,
                  fontWeight: FontWeight.w700,
                ),
                children: [
                  TextSpan(
                    text: " Gift Cash",
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: context.colorScheme.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Gap(Spacing.normal),
          Assets.images.imgOn1.image(),
          Gap(Spacing.normal),
          Text('How It Works', style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700)),
          Gap(Spacing.normal),
          _PointBullet(text: 'Browse news summaries inside the app', icons: Assets.icons.onBoarding.icSummary.path),
          Gap(Spacing.xSmall),
          _PointBullet(text: 'Read full articles in browser', icons: Assets.icons.onBoarding.icNews.path),
          Gap(Spacing.xSmall),
          _PointBullet(
            text: 'Enter the 4-digit code to collect reward points daily',
            icons: Assets.icons.onBoarding.icCode.path,
          ),
          Gap(Spacing.xSmall),
          _PointBullet(text: 'Redeem available digital rewards such as PayPal.', icons: Assets.icons.icGift.path),
        ],
      ),
    );
  }
}

class _PointBullet extends StatelessWidget {
  final String text;
  final String icons;

  const _PointBullet({required this.text, required this.icons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.normal),
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: ShapeBorderRadius.medium,
          boxShadow: [
            BoxShadow(
              color: context.colorScheme.shadow.withColorOpacity(.08),
              offset: Offset(0, 2),
              blurRadius: 8,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withColorOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icons,
                colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                height: 20,
                width: 20,
              ),
            ),
            Gap(Spacing.small),
            Expanded(child: Text(text, style: context.textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}
