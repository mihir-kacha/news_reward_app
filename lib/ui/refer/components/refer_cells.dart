part of '../refer.dart';

class _DataCell extends StatelessWidget {
  final String icon;
  final String title;
  final String subTitle;
  final String info;
  final Color color;

  const _DataCell({
    required this.icon,
    required this.title,
    required this.subTitle,
    required this.color,
    required this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.medium),
      decoration: BoxDecoration(
        color: color.withColorOpacity(.08),
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: color.withColorOpacity(.1)),
        // boxShadow: [
        //   BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 4, offset: Offset(0, 0)),
        // ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.normal),
            decoration: BoxDecoration(color: color.withColorOpacity(.1), shape: BoxShape.circle),
            child: SvgPicture.asset(icon, width: 24, height: 24, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          ),
          Gap(Spacing.medium),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subTitle,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  info,
                  style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.surfaceTint),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferCodeCell extends StatelessWidget {
  const _ReferCodeCell();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withColorOpacity(.03),
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: context.colorScheme.primary.withColorOpacity(.1)),
        // boxShadow: [
        //   BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 4, offset: Offset(0, 0)),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Assets.icons.icGift.svg(
                height: 20,
                colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
              ),
              Gap(Spacing.small),
              RichText(
                text: TextSpan(
                  text: "Earn ",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w600,
                  ),
                  children: [
                    TextSpan(
                      text: "50 points ",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: "per friend refer",
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.shadow,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Gap(Spacing.medium),
          DashedBorderContainer(
            padding: EdgeInsetsGeometry.zero,
            dashColor: context.colorScheme.primary.withColorOpacity(.1),
            borderRadius: Spacing.medium,
            child: Container(
              padding: EdgeInsets.all(Spacing.medium),
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withColorOpacity(.05),
                borderRadius: ShapeBorderRadius.medium,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "17FC92C7",
                    style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.secondary),
                  ),
                  CommonButton.cupertino(
                    onTap: () {
                      HapticFeedback.vibrate();
                      Clipboard.setData(ClipboardData(text: "17FC92C7"));
                    },
                    child: Icon(Icons.copy, color: context.colorScheme.shadow),
                  ),
                ],
              ),
            ),
          ),

          Gap(Spacing.xSmall),
          Text(
            "Your Invite Code",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surfaceTint,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferCells extends StatelessWidget {
  const _ReferCells();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        borderRadius: ShapeBorderRadius.medium,
        border: Border.all(color: context.colorScheme.outlineVariant),
        // boxShadow: [
        //   BoxShadow(color: context.colorScheme.shadow.withColorOpacity(.1), blurRadius: 4, offset: Offset(0, 0)),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Assets.icons.icAddFriend.svg(
                height: 20,
                colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
              ),
              Gap(Spacing.small),
              Expanded(
                child: Text(
                  "Add Friend Code",
                  style: context.textTheme.titleLarge?.copyWith(
                    color: context.colorScheme.shadow,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Gap(Spacing.medium),
            Row(
            children: [
              Expanded(
                flex: 3,
                child: AppInputField(
                  borderRadius: Spacing.medium,
                  fillColor: context.colorScheme.secondary.withColorOpacity(.1),
                  filled: true,
                  borderColor: context.colorScheme.primary.withColorOpacity(.1),
                ),
              ),
              Gap(Spacing.medium),
              Expanded(
                flex: 2,
                child: FilledButton(
                  // style: FilledButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.medium)),
                  onPressed: () {},
                  child: Text(
                    "Apply",
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
