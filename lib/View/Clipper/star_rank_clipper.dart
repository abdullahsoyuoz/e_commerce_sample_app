import 'dart:ui';

import 'package:flutter/material.dart';

class StarRankPainter extends CustomClipper<Path> {
  double rank;
  StarRankPainter(
      {Key? key, required this.animationController, required this.rank})
      : super(reclip: animationController);

  late AnimationController animationController;
  
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(lerpDouble(0, size.width, animationController.value)!, size.height);
    path.lineTo(lerpDouble(0, size.width, animationController.value)!, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
