// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'dart:math' as math;

Route fadeRouteBuilder(
  BuildContext context,
  Widget routePage, {
  Color? barrierColor,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 500),
    barrierColor: barrierColor ?? Colors.transparent,
    barrierDismissible: false,
    opaque: false,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation) {
      return routePage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation, Widget child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

Route leftSlideRouteBuilder(
  BuildContext context,
  Widget routePage, {
  Color? barrierColor,
  Duration? transitionDuration,
  Duration? reverseTransitionDuration,
}) {
  return PageRouteBuilder(
    transitionDuration: transitionDuration ?? const Duration(milliseconds: 300),
    barrierColor: barrierColor ?? Colors.transparent,
    barrierDismissible: false,
    opaque: false,
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation) {
      return routePage;
    },
    transitionsBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secAnimation, Widget child) {
      final Animation<Offset> offsetAnimation = Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.ease,
          reverseCurve: Curves.ease,
        ),
      );
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
