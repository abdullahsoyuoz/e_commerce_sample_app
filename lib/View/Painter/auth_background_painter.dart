// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class AuthBackgroundPainter extends CustomPainter {
  BuildContext context;
  AuthBackgroundPainter({
    Animation<double> animation,
    this.context,
  }) : super(repaint: animation) {
    curvedAnimation = CurvedAnimation(parent: animation, curve: Curves.ease);
  }

  Animation<double> curvedAnimation;

  @override
  void paint(Canvas canvas, Size size) {
    paintLevel1(canvas, size);
    paintLevel2(canvas, size);
    paintLevel3(canvas, size);
  }

  void paintLevel1(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value), 0);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value), size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = Provider.of<ThemeChanger>(context, listen: false).isDark()
              ? AppColors.black.shade100
              : AppColors.grey.shade100
          ..style = PaintingStyle.fill);
  }

  void paintLevel2(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value), 0);
    path.lineTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value), 0);
    path.lineTo(lerpDouble(size.width, size.width * 0.5, curvedAnimation.value),
        size.height);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value), size.height);
    path.close();
    canvas.drawPath(
        path,
        Paint()
          ..color = Provider.of<ThemeChanger>(context, listen: false).isDark()
              ? AppColors.black.shade200
              : AppColors.grey.shade200
          ..style = PaintingStyle.fill);
  }

  void paintLevel3(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(lerpDouble(size.width, size.width * 0.5, curvedAnimation.value),
        size.height);

    canvas.drawPath(
      path,
      Paint()
        ..color = Provider.of<ThemeChanger>(context, listen: false).isDark()
            ? AppColors.black.shade300
            : AppColors.grey.shade300
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
