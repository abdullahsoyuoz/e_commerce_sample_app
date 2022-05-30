import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';

class SemiCirclePainter extends CustomPainter {
  BuildContext context;
  bool fromRight;
  SemiCirclePainter(this.context, {this.fromRight = true});

  @override
  void paint(Canvas canvas, Size size) {
    fromRight ? paintSemiCircleFromRight(canvas, size) : paintSemiCircleFromLeft(canvas, size);
  }

  void paintSemiCircleFromRight(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Provider.of<ThemeChanger>(context, listen: false).isDark()
          ? Colors.white
          : Colors.black;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width - 20, 0);
    path.arcToPoint(Offset(size.width - 20, size.height),
        radius: Radius.circular(size.height * 0.5));
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }
  
  void paintSemiCircleFromLeft(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Provider.of<ThemeChanger>(context, listen: false).isDark()
          ? Colors.white
          : Colors.black;

    Path path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(20, 0);
    path.arcToPoint(Offset(20, size.height),
        radius: const Radius.circular(20), clockwise: false);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
