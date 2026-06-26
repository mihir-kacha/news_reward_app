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
          Row(
            spacing: Spacing.medium,
            children: [
              _BoardingCell(
                icon: Assets.icons.onBoarding.icNote.path,
                title: "Read News",
                subTitle: "Browse latest news and stay updated.",
              ),
              _BoardingCell(
                icon: Assets.icons.onBoarding.icCoins.path,
                title: "Earn coins",
                subTitle: "Read daily and earn reward coin.",
              ),
              _BoardingCell(
                icon: Assets.icons.icGift.path,
                title: "Redeem rewards",
                subTitle: "Redeem coins for amazing rewards",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BoardingCell extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;

  const _BoardingCell({required this.icon, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Spacing.small),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withColorOpacity(.08),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                icon,
                height: 24,
                width: 24,
                colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
              ),
            ),
            Gap(Spacing.small),
            Text(
              title,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Gap(Spacing.xSmall),
            Text(
              subTitle,
              style: context.textTheme.labelSmall?.copyWith(
                color: context.colorScheme.surfaceTint,
                fontWeight: FontWeight.w300,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
