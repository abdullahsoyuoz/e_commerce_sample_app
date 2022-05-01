// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';

class FadePainter extends CustomPainter {
  Color fadeColor;
  BuildContext context;
  FadePainter({required this.fadeColor, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromPoints(Offset.zero, Offset(size.width, size.height));
    LinearGradient lg = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [
          0,
          0.9
        ],
        colors: [
          //create 2 white colors, one transparent
          Colors.transparent,
          fadeColor.withOpacity(1)
        ]);
    Paint paint = Paint()
      ..shader = lg.createShader(rect)
      ..blendMode = Provider.of<ThemeChanger>(context, listen: false).isDark() ? BlendMode.darken : BlendMode.lighten;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}