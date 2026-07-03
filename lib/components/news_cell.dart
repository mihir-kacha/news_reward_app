import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';
import 'package:inshorts/ui/news_detail/news_detail.dart';
import 'package:inshorts/utils/catches_network_images.dart';
import 'package:inshorts/utils/common_button.dart';
import 'package:network/network.dart';

class NewsCell extends StatelessWidget {
  final NewsData newsData;

  const NewsCell({super.key, required this.newsData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.normal),
      child: CommonButton.cupertino(
        onTap: () => NavigationAdHelper.instance.navigate(
          onComplete: () {
            context.navigator.pushNamed(NewsDetailScreen.routeName, arguments: newsData);
          },
        ),
        child: Container(
          padding: EdgeInsets.all(Spacing.medium),
          decoration: BoxDecoration(
            color: context.colorScheme.onPrimary,
            borderRadius: ShapeBorderRadius.normal,
            boxShadow: [
              BoxShadow(
                color: context.colorScheme.shadow.withColorOpacity(.08),
                spreadRadius: 0,
                offset: Offset(0, 2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              NetworkImageBuilder.square(
                url: newsData.imageUrl,
                size: 80,
                boxFit: BoxFit.cover,
                radius: ShapeBorderRadius.medium,
                placeholderBuilder: (context) {
                  return Container(
                    color: context.colorScheme.primary.withColorOpacity(.03),
                    child: Center(child: Icon(Icons.newspaper)),
                  );
                },
              ),
              Gap(Spacing.medium),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsData.title ?? "",
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.shadow,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(Spacing.xSmall),
                    Container(
                      width: context.width,
                      padding: EdgeInsets.symmetric(vertical: Spacing.small, horizontal: Spacing.medium),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: ShapeBorderRadius.xxxLarge,
                      ),
                      alignment: Alignment.center,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
