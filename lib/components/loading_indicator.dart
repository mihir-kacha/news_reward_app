
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inshorts/core/core.dart';

class LoadingIndicator extends StatefulWidget {
  const LoadingIndicator({super.key});

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
    return Center(child: _GradientCircularProgressIndicator());
  }
}

class _GradientCircularProgressIndicator extends StatefulWidget {
  final double radius;
  final double strokeWidth;

  const _GradientCircularProgressIndicator({this.radius = 28, this.strokeWidth = 10.0});

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
    double centerPoint = size.height / 2;

    Paint paint = Paint()
      ..color = gradientColors.first
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    paint.shader = SweepGradient(
      colors: gradientColors.reversed.toList(),
      tileMode: TileMode.repeated,
      startAngle: _degreeToRad(270),
      endAngle: _degreeToRad(270 + 360.0),
    ).createShader(Rect.fromCircle(center: Offset(centerPoint, centerPoint), radius: 0));
    // 1
    var scapSize = strokeWidth * 0.70;
    double scapToDegree = scapSize / centerPoint;
    // 2
    double startAngle = _degreeToRad(270) + scapToDegree;
    double sweepAngle = _degreeToRad(360) - (2 * scapToDegree);

    canvas.drawArc(
      Offset(0.0, 0.0) & Size(size.width, size.width),
      startAngle,
      sweepAngle,
      false,
      paint..color = gradientColors.first,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
