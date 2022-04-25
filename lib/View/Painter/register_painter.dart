import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/curves.dart';

class RegisterPainter extends CustomPainter {
  RegisterPainter({required this.animation}):super(repaint: animation){
    brush = Paint()
      ..color = AppColors.purple.shade300
      ..style = PaintingStyle.fill;

    curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: const SpringCurve(),
    );
  }
  
  late Paint brush;
  late final Animation<double> curvedAnimation;
  late AnimationController animation;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height / 5 * animation.value);
    path.lineTo(0, size.height / 5 * animation.value);
    path.close();
    canvas.drawPath(path, brush..color);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
