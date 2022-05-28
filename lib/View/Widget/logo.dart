import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'dart:math' as math;

import 'package:sepet_demo/Controller/Provider/theme_provider.dart';

class LogoWidget extends StatelessWidget {
  final double size;
  final Color color;
  const LogoWidget({Key key, this.size, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
        angle: math.pi / 4,
        child: Image.asset(
          Provider.of<ThemeChanger>(context, listen: false).isDark() ? combinDark : combinLight,
          width: size ?? context.width,
          height: size ?? context.width,
          color: color ?? Theme.of(context).iconTheme.color,
        ));
  }
}
