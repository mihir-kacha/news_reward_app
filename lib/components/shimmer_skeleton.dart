

import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerSkeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadiusGeometry? radius;
  final Widget? child;

  const ShimmerSkeleton({super.key, this.height, this.width, this.radius, this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline,
      highlightColor: context.colorScheme.surface,
      child: Builder(
        builder: (context) {
          if (child != null) return child!;
          return Container(
            height: height,
            width: width,
            decoration: BoxDecoration(color:context.colorScheme.surfaceContainer.withColorOpacity(.6),borderRadius: radius),
          );
        },
      ),
    );
  }
}
