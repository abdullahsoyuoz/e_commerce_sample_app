// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'dart:math' as math;

class LogoWidget extends StatelessWidget {
  late double? size;
  late Color? color;
  LogoWidget({Key? key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: math.pi / 4,
        child: Stack(
          fit: StackFit.loose,
          children: [
            Icon(
              Icons.shopping_bag,
              color: color ?? Colors.white,
              size: size ?? context.width * 0.7,
            ),
          ],
        ));
  }
}
