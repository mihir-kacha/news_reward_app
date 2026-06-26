import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';

class DashedBorderContainer extends StatelessWidget {
  final Widget child;
  final Color? dashColor;
  final double borderRadius;
  final double dashWidth;
  final double dashGap;
  final double dashHeight;
  final EdgeInsetsGeometry padding;

  const DashedBorderContainer({
    super.key,
    required this.child,
    this.dashColor,
    this.borderRadius = 16,
    this.dashWidth = 4,
    this.dashGap = 4,
    this.dashHeight = 1.5,
    this.padding = const EdgeInsets.all(12),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedRRectPainter(
        color: dashColor ?? context.colorScheme.onPrimaryFixed,
        radius: borderRadius,
        dashWidth: dashWidth,
        dashGap: dashGap,
        strokeWidth: dashHeight,
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class _DashedRRectPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double dashGap;
  final double strokeWidth;

  _DashedRRectPainter({
    required this.color,
    required this.radius,
    required this.dashWidth,
    required this.dashGap,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final next = distance + dashWidth;
        final extractPath = metric.extractPath(
          distance,
          next.clamp(0, metric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashGap != dashGap ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
