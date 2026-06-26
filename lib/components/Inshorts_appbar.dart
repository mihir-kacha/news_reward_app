import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/common_button.dart';

class InshortsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final Widget? leading;
  final bool? centerTitle;
  final List<Widget>? actions;
  final bool? autoLeading;
  final TextStyle? textStyle;
  final bool? showBack;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final EdgeInsets? actionPadding;

  const InshortsAppbar({
    super.key,
    required this.title,
    this.leading,
    this.centerTitle,
    this.actions,
    this.autoLeading,
    this.textStyle,
    this.showBack,
    this.bottom,
    this.backgroundColor,
    this.actionPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleTextStyle: textStyle ?? context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
      automaticallyImplyLeading: autoLeading ?? false,
      bottom: bottom,
      leadingWidth: Spacing.xxLarge,
      leading:
          leading ??
          ((showBack ?? context.navigator.canPop())
              ? Padding(
                  padding: EdgeInsets.only(left: Spacing.normal),
                  child: CommonButton.cupertino(
                    onTap: () {
                      context.navigator.pop();
                    },
                    child: Icon(Icons.arrow_back, size: 20, color: context.colorScheme.shadow),
                  ),
                )
              : null),
      actions:
          actions ??
          [
            Container(
              padding: EdgeInsets.symmetric(horizontal: Spacing.medium, vertical: Spacing.xSmall),
              decoration: BoxDecoration(
                borderRadius: ShapeBorderRadius.xxxLarge,
                gradient: LinearGradient(
                  colors: [context.colorScheme.primary, context.colorScheme.secondary],
                  begin: Alignment.centerLeft,
                  end: AlignmentGeometry.centerRight,
                ),
              ),
              child: Row(
                children: [
                  Assets.images.imgCoin.image(height: 18),
                  Gap(Spacing.xSmall),
                  Text(
                    "100",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
      actionsPadding:
          actionPadding ?? EdgeInsets.only(top: Spacing.medium, bottom: Spacing.medium, right: Spacing.normal),
      title: title,
      centerTitle: centerTitle ?? false,
      backgroundColor: backgroundColor ?? context.colorScheme.onPrimary,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
