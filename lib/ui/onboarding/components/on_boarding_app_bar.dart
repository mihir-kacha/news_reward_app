part of '../onboarding.dart';

class _OnBoardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _OnBoardingAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.small)+ EdgeInsets.only(top: context.padding.top),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.only(bottomLeft: RadiusValues.normal, bottomRight: RadiusValues.normal),
      ),
      child: Text(
        "NewsPay : Read to Earn Money",
        style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.onPrimary),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
