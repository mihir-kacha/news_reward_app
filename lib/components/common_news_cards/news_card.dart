import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/generated/assets.gen.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/utils/catches_network_images.dart';
import 'package:network/model/model.dart';

class NewsCard extends StatelessWidget {
  final int index;
  final NewsData data;

  const NewsCard({super.key, required this.index, required this.data});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Spacing.xLarge),
      child: Material(
        color: context.colorScheme.onPrimary,
        elevation: 6,
        shadowColor: context.colorScheme.shadow.withColorOpacity(.3),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: context.height,
              color: context.colorScheme.outlineVariant,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 10,
                    child: NetworkImageBuilder(
                      boxFit: BoxFit.cover,
                      url: data.imageUrl,
                      placeholderBuilder: (context) => Container(
                        color: context.colorScheme.primaryContainer.withColorOpacity(.1),
                        child: Icon(Icons.newspaper),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: context.height / 4.5,
              child: Container(
                width: context.width,
                padding: EdgeInsets.all(Spacing.normal),
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: BorderRadius.only(topLeft: RadiusValues.xLarge, topRight: RadiusValues.xLarge),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? '',
                      style: context.textTheme.titleLarge?.copyWith(
                        color: context.colorScheme.shadow,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(Spacing.medium),
                    Text(
                      data.description ?? '',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 10,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(Spacing.medium),
                    Row(
                      children: [
                        _Info(string: getNewsTime(data.pubDate), icon: Icon(Icons.calendar_month, size: 12)),
                        if (data.creator.isNotEmpty) ...[
                          Gap(Spacing.small),
                          Text(
                            '|',
                            style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.surfaceTint),
                          ),
                          Gap(Spacing.small),
                          _Info(string: (data.creator).join(", "), icon: Icon(Icons.person, size: 12)),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: Spacing.normal,
              right: Spacing.normal,
              left: Spacing.normal,
              child: Container(
                padding: EdgeInsets.all(Spacing.medium),
                decoration: BoxDecoration(
                  color: context.colorScheme.secondary.withColorOpacity(.08),
                  borderRadius: ShapeBorderRadius.large,
                  border: Border.all(color: context.colorScheme.secondary.withColorOpacity(.3)),
                ),
                child: Row(
                  children: [
                    Assets.images.imgGiftWithCoins.image(height: 100),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Great! You've almost finished",
                            style: context.textTheme.bodyMedium?.copyWith(
                              color: context.colorScheme.shadow,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            "Earn 300 Points",
                            style: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.primary),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(Spacing.small),
                          Container(
                            width: context.width,
                            padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.large),
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
                              borderRadius: ShapeBorderRadius.xxxLarge,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Open News to Earn 300 Points",
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: context.colorScheme.onPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Gap(Spacing.small),
                                Icon(Icons.arrow_forward_ios_rounded, color: context.colorScheme.onPrimary, size: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String string;
  final Icon icon;

  const _Info({required this.string, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        Gap(Spacing.xSmall),
        Text(string, style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.surfaceTint)),
      ],
    );
  }
}
