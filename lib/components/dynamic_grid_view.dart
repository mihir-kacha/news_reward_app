import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DynamicHeightGridView extends StatelessWidget {
  const DynamicHeightGridView({
    Key? key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.adBuilder
  });

  final IndexedWidgetBuilder builder;
  final IndexedWidgetBuilder? adBuilder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool shrinkWrap;

  int columnLength() {
    if (itemCount % crossAxisCount == 0) {
      return itemCount ~/ crossAxisCount;
    } else {
      return (itemCount ~/ crossAxisCount) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding,
      itemBuilder: (ctx, columnIndex) {
        return _GridRow(
          columnIndex: columnIndex,
          builder: builder,
          itemCount: itemCount,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisAlignment: rowCrossAxisAlignment,
          adBuilder: adBuilder,
        );
      },
      itemCount: columnLength(),
    );
  }
}

class _GridRow extends StatelessWidget {
  const _GridRow({
    required this.columnIndex,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisAlignment,
    this.adBuilder
  });

  final IndexedWidgetBuilder builder;
  final IndexedWidgetBuilder? adBuilder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment crossAxisAlignment;
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    final gap = (columnIndex == 0) ? 0 : mainAxisSpacing;
    return Column(
      children: [
        Builder(
          builder: (context) {
            if (adBuilder != null) {
              return adBuilder!(context, columnIndex);
            }
            return SizedBox.shrink();
          },
        ),
        Gap(gap.toDouble()),
        Row(
          crossAxisAlignment: crossAxisAlignment,
          children: List.generate((crossAxisCount * 2) - 1, (rowIndex) {
            final rowNum = rowIndex + 1;
            if (rowNum % 2 == 0) {
              return SizedBox(width: crossAxisSpacing);
            }
            final rowItemIndex = ((rowNum + 1) ~/ 2) - 1;
            final itemIndex = (columnIndex * crossAxisCount) + rowItemIndex;
            if (itemIndex > itemCount - 1) {
              return const Expanded(child: SizedBox());
            }
            return Expanded(child: builder(context, itemIndex));
          }),
        ),
      ],
    );
  }
}
