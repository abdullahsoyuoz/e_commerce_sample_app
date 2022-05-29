import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class GettingStartedPainter extends CustomPainter {
  BuildContext context;
  GettingStartedPainter(this.context);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Theme.of(context).colorScheme.primaryContainer;
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
