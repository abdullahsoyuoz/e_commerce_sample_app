import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'dart:math' as math;

class OnboardingPainter extends CustomPainter {
  OnboardingPainter({this.animation}) : super(repaint: animation) {
    level1Paint = Paint()..style = PaintingStyle.fill;
    level2Paint = Paint()..style = PaintingStyle.fill;
  }

  Animation<double> animation;
  Paint level1Paint;
  Paint level2Paint;
  Paint level3Paint;

  @override
  void paint(Canvas canvas, Size size) {
    paintLevel1(canvas, size);
    paintBackground(canvas, size);
    paintSliceProgress(canvas, size);
  }

  void paintLevel1(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(lerpDouble(size.width / 4, size.width, animation.value / 3), 0);
    path.lineTo(lerpDouble(size.width / 4, size.width, animation.value / 3),
        size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(
      path,
      level1Paint..color = getColor(animation.value).withOpacity(.5),
    );
  }

  void paintBackground(Canvas canvas, Size size) {
    canvas.drawRect(Rect.largest,
        level2Paint..color = getColor(animation.value).withOpacity(0.75));
  }

  void paintSliceProgress(Canvas canvas, Size size) {
    Path path = Path();
    canvas.drawArc(
      Rect.fromPoints(
        Offset(size.width * 0.5 - 25, size.height - 50),
        Offset(size.width * 0.5 + 25, size.height - 100),
      ),
      -math.pi / 2,
      math.pi * animation.value / 2 + math.pi / 2,
      true,
      Paint()
        ..color = Colors.white
        ..strokeWidth = 5
        ..style = PaintingStyle.fill,
    );

    canvas.drawPath(path, level1Paint..color = getColor(animation.value));
  }

  Color getColor(double value) {
    if (value <= 1) {
      return Color.lerp(AppColors.purple.shade300, AppColors.orange.shade300,
          animation.value);
    }
    if (value <= 2) {
      return Color.lerp(AppColors.orange.shade300, AppColors.red.shade300,
          animation.value - 1);
    }
    if (value <= 3) {
      return Color.lerp(
          AppColors.red.shade300, AppColors.blue.shade300, animation.value - 2);
    }
    return Color.lerp(
        AppColors.grey.shade300, AppColors.grey.shade300, animation.value);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
