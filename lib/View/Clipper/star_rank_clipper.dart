import 'dart:ui';

import 'package:flutter/material.dart';

class StarRankPainter extends CustomClipper<Path> {
  double? rank;
  bool animate;
  StarRankPainter(
      {Key? key, this.animationController, this.rank, this.animate = false})
      : super(reclip: animationController);

  AnimationController? animationController;

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    animate ? path.lineTo(lerpDouble(0, size.width, animationController!.value)!, size.height) : path.lineTo(30 * rank!, size.height);
    animate ? path.lineTo(lerpDouble(0, size.width, animationController!.value)!, 0) : path.lineTo(30 * rank!, 0);
    path.close();
    return path;
  }

  Path getClipViaAnimation(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(
        lerpDouble(0, size.width, animationController!.value)!, size.height);
    path.lineTo(lerpDouble(0, size.width, animationController!.value)!, 0);
    path.close();
    return path;
  }

  Path getClipWithoutAnimation(Size size) {
    debugPrint(size.width.toString());
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(30 * rank!, size.height);
    path.lineTo(30 * rank!, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
