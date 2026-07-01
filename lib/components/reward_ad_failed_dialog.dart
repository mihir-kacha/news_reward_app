import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/components/model.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';

class RewardAdFailedDialog extends StatelessWidget {
  const RewardAdFailedDialog({super.key});

  static Future<void> show(BuildContext context) async {
    return await showAppDialog(context: context, builder: (context) => const RewardAdFailedDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Spacing.small, vertical: Spacing.small),
            child: IconButton.filled(
              padding: EdgeInsets.all(Spacing.xSmall),
              iconSize: 24,
              style: IconButton.styleFrom(
                backgroundColor: context.colorScheme.primary.withColorOpacity(0.1),
                minimumSize: const Size(Spacing.small, Spacing.small),
              ),
              icon: Icon(Icons.close, color: context.colorScheme.onSurface),
              onPressed: () {
                context.navigator.pop();
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(Spacing.large) + EdgeInsets.only(bottom: Spacing.medium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(Spacing.large),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      context.colorScheme.primary.withColorOpacity(0.14),
                      context.colorScheme.onPrimary.withColorOpacity(0.01),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Assets.images.imgWatchAdFailed.image(height: 130),
              ),
              Text("Reward Failed", style: context.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700)),
              Gap(Spacing.xSmall),
              Text(
                "We couldn\'t complete the reward process right now. Please try again in a moment.",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: context.colorScheme.onSurface.withColorOpacity(.6),
                ),
                textAlign: TextAlign.center,
              ),
              Gap(Spacing.medium),
              Container(
                padding: EdgeInsets.all(Spacing.medium),
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(borderRadius: ShapeBorderRadius.normal),
                  color: context.colorScheme.primary.withColorOpacity(0.08),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(Spacing.small),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: context.colorScheme.primary.withColorOpacity(.14),
                      ),
                      child: Icon(CupertinoIcons.checkmark_shield, color: context.colorScheme.primary, size: 30),
                    ),
                    Gap(Spacing.medium),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Your progress is safe",
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Gap(Spacing.xSmall),
                          Text(
                            "You can try again anytime to continue earning your reward.",
                            style: context.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
