// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';

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
    final paint1 = Paint()
      ..color = Theme.of(context).colorScheme.primaryContainer
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Theme.of(context).colorScheme.secondaryContainer
      ..style = PaintingStyle.fill;

    final paint3 = Paint()
      ..color = Theme.of(context).colorScheme.tertiaryContainer
      ..style = PaintingStyle.fill;

    paintLevel1(canvas, size, paint1);
    paintLevel2(canvas, size, paint2);
    paintLevel3(canvas, size, paint3);
  }

  void paintLevel1(Canvas canvas, Size size, Paint paint) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value), 0);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value), size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  void paintLevel2(Canvas canvas, Size size, Paint paint) {
    Path path = Path();
    path.moveTo(lerpDouble(size.width * 0.5, 0, curvedAnimation.value), 0);
    path.lineTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value), 0);
    path.lineTo(lerpDouble(size.width, size.width * 0.5, curvedAnimation.value),
        size.height);
    path.lineTo(
        lerpDouble(size.width * 0.5, 0, curvedAnimation.value), size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  void paintLevel3(Canvas canvas, Size size, Paint paint) {
    Path path = Path();
    path.moveTo(
        lerpDouble(size.width, size.width * 0.5, curvedAnimation.value), 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(lerpDouble(size.width, size.width * 0.5, curvedAnimation.value),
        size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
