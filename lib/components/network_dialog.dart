import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/components/model.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';

class NetworkDialog extends StatelessWidget {
  final VoidCallback onRefresh;

  const NetworkDialog({super.key, required this.onRefresh});

  static Future show({required BuildContext context, required VoidCallback onRefresh}) async {
    return await showAppDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => NetworkDialog(onRefresh: onRefresh),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Spacing.normal),
      decoration: BoxDecoration(color: context.colorScheme.onPrimary, borderRadius: ShapeBorderRadius.normal),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.normal),
            decoration: BoxDecoration(color: context.colorScheme.errorContainer, shape: BoxShape.circle),
            child: Assets.icons.icWifi.svg(
              height: 24,
              width: 24,
              colorFilter: ColorFilter.mode(context.colorScheme.error, BlendMode.srcIn),
            ),
          ),
          Gap(Spacing.xLarge),
          Text(
            "No Internet",
            style: context.textTheme.titleLarge?.copyWith(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(Spacing.xSmall),
          Text(
            "Please check your connection and try again",
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.surfaceTint,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(Spacing.xLarge),
          FilledButton(
            style: FilledButton.styleFrom(fixedSize: Size.fromWidth(context.width)),
            onPressed: onRefresh,
            child: Text("Retry", style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary)),
          ),
        ],
      ),
    );
  }
}
