import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'dart:math' as math;

class LogoWidget extends StatelessWidget {
  final double? size;
  final Color? color;
  const LogoWidget({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: math.pi / 4,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Icon(
              LineIcons.shoppingBag,
              color: color ?? Colors.white,
              size: size ?? context.width * 0.7,
            ),
          ],
        ));
  }
}
