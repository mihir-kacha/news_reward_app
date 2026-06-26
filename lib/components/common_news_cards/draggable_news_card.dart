import 'package:flutter/material.dart';
import 'package:inshorts/components/common_news_cards/news_card.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/utils/app_constant.dart';
import 'package:network/network.dart';

class DraggableNewsCard extends StatefulWidget {
  final int index;
  final NewsData data;
  final void Function(double progress) updateProgress;
  final void Function(bool draggingDown) setDirection;
  final void Function(int index) changeNews;
  final int currentIndex;
  final int newsLength;

  const DraggableNewsCard({
    super.key,
    required this.index,
    required this.data,
    required this.updateProgress,
    required this.setDirection,
    required this.changeNews,
    required this.currentIndex,
    required this.newsLength,
  });

  @override
  State<DraggableNewsCard> createState() => _DraggableNewsCardState();
}

class _DraggableNewsCardState extends State<DraggableNewsCard> {
  double offsetY = 0;
  bool dismissing = false;

  @override
  void didUpdateWidget(covariant DraggableNewsCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.index != widget.index) {
      offsetY = 0;
      dismissing = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onVerticalDragUpdate: (details) {
        if (dismissing) return;
        setState(() {
          offsetY += details.delta.dy;
          offsetY = offsetY.clamp(-context.height, context.height);
        });
        widget.setDirection(offsetY > 0);
        widget.updateProgress(offsetY.abs() / (context.height * .60));
      },

      onVerticalDragEnd: (details) {
        final threshold = context.height * .15;
        final velocity = details.primaryVelocity ?? 0;
        final currentIndex = widget.currentIndex;
        final dismissUp = offsetY < -threshold || velocity < -800;
        final dismissDown = offsetY > threshold || velocity > 800;
        if (dismissUp && currentIndex < widget.newsLength - 1) {
          setState(() {
            dismissing = true;
            offsetY = -context.height;
          });
          widget.updateProgress(1);
          Future.delayed(const Duration(milliseconds: 250), () {
            if (!mounted) return;
            widget.changeNews(currentIndex + 1);
          });
        } else if (dismissDown && currentIndex > 0) {
          setState(() {
            dismissing = true;
            offsetY = context.height;
          });
          widget.updateProgress(1);
          Future.delayed(const Duration(milliseconds: 250), () {
            if (!mounted) return;
            widget.changeNews(currentIndex - 1);
          });
        } else {
          setState(() {
            offsetY = 0;
            dismissing = false;
          });
          widget.updateProgress(0);
        }
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: dismissing ? 250 : 300),
        curve: dismissing ? Curves.easeOutCubic : Curves.easeOutBack,
        transform: Matrix4.translationValues(0, offsetY, 0),
        child: NewsCard(index: widget.index, data: widget.data),
      ),
    );
  }
}
