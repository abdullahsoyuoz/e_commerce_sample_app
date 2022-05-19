// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class AuthBackgroundPainter extends CustomPainter {
  bool isDark;
  AuthBackgroundPainter({
    required Animation<double> animation,
    required this.isDark,
  }) : super(repaint: animation) {
    curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.ease);
    paint1 = Paint()
      ..color = isDark ? AppColors.black.shade100 : AppColors.grey.shade100
      ..style = PaintingStyle.fill;
    paint2 = Paint()
      ..color = isDark ? AppColors.black.shade200 : AppColors.grey.shade200
      ..style = PaintingStyle.fill;
    paint3 = Paint()
      ..color = isDark ? AppColors.black.shade300 : AppColors.grey.shade300
      ..style = PaintingStyle.fill;
  }

  late final Animation<double> curvedAnimation;
  late final paint1;
  late final paint2;
  late final paint3;

  @override
  void paint(Canvas canvas, Size size) {
    paintLevel1(canvas, size);
    paintLevel2(canvas, size);
    paintLevel3(canvas, size);
  }

  void paintLevel1(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value)!, 0);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value)!, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint1);
  }

  void paintLevel2(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value)!, 0);
    path.lineTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value)!, 0);
    path.lineTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value)!,
        size.height);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value)!, size.height);
    path.close();
    canvas.drawPath(path, paint2);
  }

  void paintLevel3(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value)!, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value)!,
        size.height);

    canvas.drawPath(
      path,
      paint3,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
