import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';

class InshortsCoinCard extends StatelessWidget {
  const InshortsCoinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: context.width,
          padding: EdgeInsets.all(Spacing.normal),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [context.colorScheme.primary, context.colorScheme.secondary],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: ShapeBorderRadius.normal,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total Balance",
                style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onPrimary),
              ),
              Gap(Spacing.xSmall),
              Text("100", style: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.onPrimary)),
              Gap(Spacing.xSmall),
              RichText(
                text: TextSpan(
                  text: "\u2248",
                  style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                  children: [
                    TextSpan(
                      text: " \$3.3",
                      style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
              Gap(Spacing.small),
              Container(
                padding: EdgeInsets.symmetric(vertical: Spacing.xSmall, horizontal: Spacing.medium),
                decoration: BoxDecoration(
                  borderRadius: ShapeBorderRadius.xxxLarge,
                  border: Border.all(color: context.colorScheme.onPrimary.withColorOpacity(.3),width: 2),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.images.imgCoin.image(height: 18),
                    Gap(Spacing.small),
                    Text(
                      "100 coins",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: Spacing.normal,
          child: Assets.images.imgWalletWithCard.image(width: context.width / 2.5, height: context.width / 2.5),
        ),
      ],
    );
  }
}
