import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class FadePainter extends CustomPainter {
  Color fadeColor;
  FadePainter({required this.fadeColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(size.width * 0.5, size.height * 0.4),
        Offset(size.width * 0.5, size.height),
        [
          fadeColor,
          Colors.transparent,
        ],
      )
      ..blendMode = BlendMode.dstATop;

    canvas.drawPaint(paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
