import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:inshorts/components/shimmer_skeleton.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';

class NetworkImageBuilder extends StatelessWidget {
  final String? url;
  final double? height;
  final double? width;
  final WidgetBuilder? placeholderBuilder;
  final VoidCallback? onPress;
  final VoidCallback? onLongPress;
  final BoxShape? shape;
  final BorderRadius? radius;
  final BoxFit? boxFit;
  final FilterQuality? filterQuality;

  const NetworkImageBuilder({
    super.key,
    this.url,
    this.height,
    this.width,
    this.placeholderBuilder,
    this.onPress,
    this.onLongPress,
    this.shape,
    this.radius,
    this.boxFit,
    this.filterQuality,
  });

  const NetworkImageBuilder.square({
    super.key,
    this.url,
    this.placeholderBuilder,
    this.onPress,
    this.onLongPress,
    this.radius,
    this.boxFit,
    this.filterQuality,
    double size = 48,
  }) : height = size,
       width = size,
       shape = BoxShape.rectangle;

  const NetworkImageBuilder.circle({
    super.key,
    this.url,
    this.placeholderBuilder,
    this.onPress,
    this.onLongPress,
    this.boxFit,
    this.filterQuality,
    double size = 48,
  }) : height = size,
       width = size,
       shape = BoxShape.circle,
       radius = null;

  @override
  Widget build(BuildContext context) {
    final imageUrl = url ?? "";
    final effectiveShape = shape ?? BoxShape.rectangle;
    final effectiveBorderRadius = effectiveShape == BoxShape.circle ? null : radius;
    final effectiveShapeBorder = switch (effectiveShape) {
      BoxShape.rectangle => RoundedRectangleBorder(borderRadius: effectiveBorderRadius ?? ShapeBorderRadius.none),
      BoxShape.circle => const CircleBorder(),
    };
    final placeHolder = Builder(
      builder:
          placeholderBuilder ??
          (context) => Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(color: context.colorScheme.surfaceContainer),
            child: Icon(Icons.newspaper),
          ),
    );
    Widget child = Visibility(
      visible: imageUrl.isNotEmpty,
      replacement: Container(
        height: height,
        width: width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: ShapeDecoration(shape: effectiveShapeBorder, color: context.colorScheme.surfaceContainer),
        child: placeHolder,
      ),
      child: Builder(
        builder: (context) {
          if (imageUrl.isEmpty) {
            return SizedBox.shrink();
          }
          return ExtendedImage.network(
            imageUrl,
            height: height,
            width: width,
            fit: boxFit,
            // headers: {
            //   ApiKeys.authorization:  '${ApiKeys.bearer} ${NetworkPrefs.getToken()??""}'
            // },
            shape: effectiveShape,
            borderRadius: effectiveBorderRadius,
            enableLoadState: true,
            handleLoadingProgress: true,
            filterQuality: filterQuality ?? FilterQuality.low,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.loading) {
                return ShimmerSkeleton();
              }

              if (state.extendedImageLoadState == LoadState.failed ||
                  state.extendedImageLoadState == LoadState.loading) {
                return placeHolder;
              }
              return null;
            },
          );
        },
      ),
    );

    if (onPress != null || onLongPress != null) {
      child = GestureDetector(onTap: onPress, onLongPress: onLongPress, child: child);
    }

    return Material(type: MaterialType.card, shape: effectiveShapeBorder, child: child);
  }
}
