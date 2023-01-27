// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Page/Auth/getting_started.dart';
import 'package:sepet_demo/View/Painter/splash_painter.dart';
import 'package:sepet_demo/View/Widget/logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
    Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const GettingStarted()),
        (route) => false,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: SplashPainter(animation: animationController),
              ),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: animationController.value,
                  child: child,
                );
              },
              child: Center(
                  child: LogoWidget(
                color: Colors.white,
                size: context.width * 0.5,
              )),
            ),
            AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: animationController.value,
                  child: child,
                );
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Produced by ',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Image.asset(
                        logoSyz,
                        color: Colors.white,
                        width: context.width * 0.15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
