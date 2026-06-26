part of '../profile.dart';

class ExitSheet extends StatelessWidget {
  final VoidCallback onDone;

  const ExitSheet({super.key, required this.onDone});

  static Future<void> show({required BuildContext context, required VoidCallback onDone}) async {
    return await showAppModal(
      barrierDismissible: true,
      context: context,
      builder: (context) => ExitSheet(onDone: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      padding: EdgeInsets.all(Spacing.normal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.normal),
            decoration: BoxDecoration(color: context.colorScheme.errorContainer, shape: BoxShape.circle),
            child: Assets.icons.profile.icLogout.svg(
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(context.colorScheme.error, BlendMode.srcIn),
            ),
          ),
          Gap(Spacing.xLarge),
          Text(
            "Log Out",
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(Spacing.xSmall),
          Text(
            "Are you sure you want to logout \nfrom your account?",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surfaceTint,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(Spacing.xLarge),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: context.colorScheme.outlineVariant),
                  onPressed: () {
                    context.navigator.pop();
                  },
                  child: Text(
                    "Cancel",
                    style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.surfaceTint),
                  ),
                ),
              ),
              Gap(Spacing.medium),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(backgroundColor: context.colorScheme.error),
                  onPressed: onDone,
                  child: Text(
                    "Log Out",
                    style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
