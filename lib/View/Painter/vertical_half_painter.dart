import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HalfPainter extends CustomPainter {
  HalfPainter({
    this.context,
    this.leftColor,
    this.rightColor,
  });
  BuildContext context;
  Color leftColor;
  Color rightColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (leftColor != null) {
      leftPaint(canvas, size, leftColor);
    }
    if (rightColor != null) {
      rightPaint(canvas, size, rightColor);
    }
  }

  void leftPaint(Canvas canvas, Size size, Color color) {
    Paint paint = Paint()
      ..color = color;
    Path path = Path();
    path.moveTo(size.width * 0.5, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    // path.conicTo(
    //     size.width * 0.2, size.height * 0.5, size.width * 0.5, size.height, 1);
    path.lineTo(size.width * 0.5, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  void rightPaint(Canvas canvas, Size size, Color color) {
    Paint paint = Paint()
      ..color = color;
    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width * 0.5, size.height);
    // path.conicTo(
    //     size.width * 0.2, size.height * 0.5, size.width * 0.5, size.height, 1);
    path.lineTo(size.width, size.height);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
