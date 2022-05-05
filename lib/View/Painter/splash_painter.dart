import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/curves.dart';

class SplashPainter extends CustomPainter {
  SplashPainter({Animation<double>? animation}) : super(repaint: animation) {
    level1Paint = Paint()
      ..color = AppColors.purple.shade300
      ..style = PaintingStyle.fill;
    level2Paint = Paint()
      ..color = AppColors.purple.shade400
      ..style = PaintingStyle.fill;
    level3Paint = Paint()
      ..color = AppColors.purple.shade500
      ..style = PaintingStyle.fill;
    curvedAnimation = CurvedAnimation(
      parent: animation!,
      curve: const SpringCurve(),
      // curve: Curves.elasticOut,
    );
  }

  late final Paint level1Paint;
  late final Paint level2Paint;
  late final Paint level3Paint;
  late final Animation<double> curvedAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    // paintLevel3(canvas, size);
    // paintLevel2(canvas, size);
    // paintLevel1(canvas, size);
    paintCircleLevel3Painter(canvas, size);
    paintCircleLevel2Painter(canvas, size);
    paintCircleLevel1Painter(canvas, size);
  }

  void paintLevel1(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height / 2);
    path.quadraticBezierTo(
      size.width / 5,
      lerpDouble(
        size.height / 2,
        size.height / 2.5,
        curvedAnimation.value,
      )!,
      lerpDouble(
        size.width / 2,
        size.width / 2.5,
        curvedAnimation.value,
      )!,
      size.height / 2,
    );
    path.quadraticBezierTo(
      size.width / 1,
      lerpDouble(
        size.height / 3,
        size.height / 1.2,
        curvedAnimation.value,
      )!,
      size.width,
      size.height / 2,
    );
    path.close();
    canvas.drawPath(path, level1Paint);
  }

  void paintLevel2(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.conicTo(
      lerpDouble(size.width, size.width * 0.5, curvedAnimation.value)!,
      lerpDouble(size.height * 0.5, size.height * 1, curvedAnimation.value)!,
      0,
      lerpDouble(size.height * 0, size.height * 0.7, curvedAnimation.value)!,
      1,
    );
    path.close();
    canvas.drawPath(path, level2Paint);
  }

  void paintLevel3(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.conicTo(
      lerpDouble(0, size.width, curvedAnimation.value)!,
      lerpDouble(size.height - size.width, size.height, curvedAnimation.value)!,
      0,
      size.height,
      lerpDouble(1, 3, curvedAnimation.value)!,
    );

    canvas.drawPath(path, level3Paint);
  }

  void paintCircleLevel1Painter(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    path.lineTo(0,lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), lerpDouble(0, size.width * 0.45, curvedAnimation.value)!, level1Paint);
  }

  void paintCircleLevel2Painter(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    path.lineTo(0,lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), lerpDouble(0, size.height * 0.45, curvedAnimation.value)!, level2Paint);
  }

  void paintCircleLevel3Painter(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    path.lineTo(0,lerpDouble(0, size.height * 0.8, curvedAnimation.value)!);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), lerpDouble(0, size.height, curvedAnimation.value)!, level3Paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
