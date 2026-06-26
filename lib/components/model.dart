import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';

Future<T> showAppDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  Color? backgroundColor,
}) async {
  return await showDialog(
    context: context,
    barrierColor: context.colorScheme.onSurface.withColorOpacity(.6),
    builder: (context) => Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: Spacing.large),
      backgroundColor: Colors.transparent,

      child: PopScope(
        canPop: barrierDismissible,
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.colorScheme.surfaceContainer,
            borderRadius: ShapeBorderRadius.normal,
            border: Border.all(color: context.colorScheme.outline, width: 2),
            boxShadow: backgroundColor == Colors.transparent
                ? []
                : [BoxShadow(color: Colors.black.withColorOpacity(0.1), blurRadius: 14, offset: Offset(0, 0))],
          ),
          child: builder(context),
        ),
      ),
    ),
  );
}

Future<T?> showAppModal<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  double? maxBottomHeight,
}) async {
  final maxHeight = maxBottomHeight ?? (context.height - kToolbarHeight - context.padding.top);
  final minHeight = context.height / 7;
  return await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) => Container(
      decoration: ShapeDecoration(
        color: context.colorScheme.onPrimary,
        shape: RoundedRectangleBorder(borderRadius: ShapeBorderRadius.xLarge),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight, minHeight: minHeight),
        child: Padding(
          padding: EdgeInsetsGeometry.only(bottom: context.padding.bottom),
          child: builder(context),
        ),
      ),
    ),
    isDismissible: barrierDismissible,
    enableDrag: barrierDismissible,
    isScrollControlled: true,
    useSafeArea: true,
  );
}
