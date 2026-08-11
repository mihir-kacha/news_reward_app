import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:inshorts/core/core.dart';
import 'package:inshorts/resources/resources.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key, this.showAdLoading = false});

  final bool showAdLoading;

  @override
  State<LoadingIndicator> createState() => _LoadingIndicatorState();
}

class _LoadingIndicatorState extends State<LoadingIndicator> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(Spacing.large),
        decoration: BoxDecoration(borderRadius: ShapeBorderRadius.medium, color: context.colorScheme.onPrimary),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [
            _GradientCircularProgressIndicator(),
            if (widget.showAdLoading) ...[
              Gap(Spacing.small),
              Text(
                "Ad Loading...",
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
    return Center(child: _GradientCircularProgressIndicator());
  }
}

class _GradientCircularProgressIndicator extends StatefulWidget {
  final double radius;
  final double strokeWidth;

  const _GradientCircularProgressIndicator({this.radius = 18, this.strokeWidth = 08.0});

  @override
  State<_GradientCircularProgressIndicator> createState() => _GradientCircularProgressIndicatorState();
}

class _GradientCircularProgressIndicatorState extends State<_GradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1))..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: RotationTransition(
        turns: _animationController,
        child: CustomPaint(
          painter: _GradientCircularProgressPainter(
            radius: widget.radius,
            gradientColors: [context.colorScheme.primary, context.colorScheme.primary, context.colorScheme.onPrimary],
            strokeWidth: widget.strokeWidth,
          ),
        ),
      ),
    );
  }
}

class _GradientCircularProgressPainter extends CustomPainter {
  _GradientCircularProgressPainter({required this.radius, required this.gradientColors, required this.strokeWidth});

  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  double _degreeToRad(double degree) => degree * math.pi / 180;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);

    final double effectiveRadius = radius - (strokeWidth / 2);

    final Rect rect = Rect.fromCircle(center: center, radius: effectiveRadius);

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..isAntiAlias = true;

    paint.shader = SweepGradient(
      colors: gradientColors,
      stops: List.generate(gradientColors.length, (index) => index / (gradientColors.length - 1)),
      startAngle: _degreeToRad(-90),
      endAngle: _degreeToRad(270),
      tileMode: TileMode.clamp,
    ).createShader(rect);

    // Small gap at the top for rounded caps.
    final double capOffset = (strokeWidth * 0.7) / effectiveRadius;

    final double startAngle = _degreeToRad(-90) + capOffset;

    final double sweepAngle = _degreeToRad(360) - (capOffset * 2);

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gradientColors != gradientColors;
  }
}

// class _GradientCircularProgressPainter extends CustomPainter {
//   _GradientCircularProgressPainter({required this.radius, required this.gradientColors, required this.strokeWidth});
//
//   final double radius;
//   final List<Color> gradientColors;
//   final double strokeWidth;
//
//   double _degreeToRad(double degree) => degree * math.pi / 200;
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     double centerPoint = size.height / 2;
//
//     Paint paint = Paint()
//       ..color = gradientColors.first
//       ..strokeCap = StrokeCap.round
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;
//
//     paint.shader = SweepGradient(
//       colors: gradientColors.reversed.toList(),
//       tileMode: TileMode.repeated,
//       startAngle: _degreeToRad(270),
//       endAngle: _degreeToRad(270 + 360.0),
//     ).createShader(Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));
//     // 1
//     var scapSize = strokeWidth * 0.70;
//     double scapToDegree = scapSize / centerPoint;
//     // 2
//     double startAngle = _degreeToRad(270) + scapToDegree;
//     double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);
//
//     canvas.drawArc(
//       Offset(0.0, 0.0) & Size(size.width, size.width),
//       startAngle,
//       sweepAngle,
//       false,
//       paint..color = gradientColors.first,
//     );
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => true;
// }
