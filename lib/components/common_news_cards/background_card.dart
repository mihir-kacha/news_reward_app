import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inshorts/components/common_news_cards/news_card.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/utils/app_constant.dart';
import 'package:inshorts/utils/enum.dart';
import 'package:network/model/model.dart';

class BackgroundCard extends StatelessWidget {
  final int index;
  final NewsData data;
  final double progress;

  // final bool fromBottom;
  // final bool blur;
  final CardPosition type;

  const BackgroundCard({
    super.key,
    required this.index,
    required this.type,
    required this.data,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final isPrevious = type == CardPosition.previous;

    return Positioned.fill(
      top: isPrevious ? lerpDouble(-context.height * .25, 0, progress)! : lerpDouble(50, 0, progress)!,
      child: Transform.scale(
        alignment: Alignment.topCenter,
        scale: lerpDouble(.90, 1.0, progress)!,
        child: Opacity(
          opacity: lerpDouble(.6, 1.0, progress)!,
          child: NewsCard(key: ValueKey(index), index: index, data: data),
        ),
      ),
    );
  }
}
