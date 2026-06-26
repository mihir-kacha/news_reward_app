import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/common_button.dart';

import '../core/core.dart';

class ReadingNewsTask extends StatelessWidget {
  final int total;
  final int coins;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isPercentage;
  final Widget icon;

  const ReadingNewsTask({
    super.key,
    required this.total,
    required this.coins,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isPercentage = false,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = 1 == total;
    return Container(
      width: context.width,
      padding: EdgeInsets.all(Spacing.medium),
      decoration: BoxDecoration(
        color: context.colorScheme.onPrimary,
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.shadow.withColorOpacity(.08),
            offset: Offset(0, 2),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
        borderRadius: ShapeBorderRadius.medium,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(Spacing.small),
            decoration: BoxDecoration(
              color: context.colorScheme.onPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: context.colorScheme.shadow.withColorOpacity(.1),
                  offset: Offset(0, 2),
                  spreadRadius: 0,
                  blurRadius: 2,
                ),
              ],
            ),
            child: icon,
          ),
          Gap(Spacing.small),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.shadow),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subtitle,
                  style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.shadow),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!isPercentage) ...[
                  Gap(Spacing.xSmall),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.images.imgCoin.image(height: 12),
                      Gap(Spacing.xSmall),
                      Text(
                        coins.formattedIndian,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.shadow,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
                Gap(Spacing.small),
                TaskProgressIndicator(current: 1, total: total, isPercentage: isPercentage),
              ],
            ),
          ),
          Gap(Spacing.small),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isPercentage) ...[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Assets.images.imgCoin.image(height: 18),
                    Gap(Spacing.xSmall),
                    Text(coins.formattedIndian, style: context.textTheme.bodyMedium),
                  ],
                ),
                Gap(Spacing.small),
              ],
              CommonButton.cupertino(
                onTap: isCompleted ? null : onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: isPercentage ? Spacing.xSmall : Spacing.small,
                    horizontal: Spacing.normal,
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: context.colorScheme.primary.withColorOpacity(.8),
                        spreadRadius: 0,
                        blurRadius: 8,
                        offset: Offset(0, 0),
                      ),
                    ],
                    color: context.colorScheme.primary,
                    borderRadius: isPercentage ? ShapeBorderRadius.xxxLarge : ShapeBorderRadius.small,
                  ),
                  child: Text(
                    "Claim",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
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

class TaskProgressIndicator extends StatelessWidget {
  final bool isPercentage;
  final int current;
  final int total;

  const TaskProgressIndicator({super.key, required this.current, required this.total, this.isPercentage = false});

  @override
  Widget build(BuildContext context) {
    final progress = (current / total);
    final percentage = progress * 100;

    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Spacing.xxxLarge),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 6,
              backgroundColor: context.colorScheme.surfaceContainerHigh,
            ),
          ),
        ),
        Gap(Spacing.small),
        Text(
          isPercentage ? '${percentage.percentage}%' : '$current/$total',
          style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.surfaceTint),
        ),
      ],
    );
  }
}
