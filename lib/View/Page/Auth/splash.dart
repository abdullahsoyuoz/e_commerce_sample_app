import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/constant.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/View/Page/Auth/onboaring.dart';
import 'package:sepet_demo/View/Painter/splash_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/route_builder.dart';
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
      duration: const Duration(seconds: 5),
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      animationController.forward();
    });
    Future.delayed(
      const Duration(seconds: 5),
      () => Navigator.push(
        context,
        customRouteBuilder(
          context,
          const OnboardPage(),
          barrierColor: AppColors.red,
        ),
      ),
    ).whenComplete((){});
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
      backgroundColor: AppColors.purple,
      body: SizedBox.expand(
        child: Stack(
          children: [
            SizedBox.expand(
              child: CustomPaint(
                painter: SplashPainter(animation: animationController),
              ),
            ),
            Center(
              child: LogoWidget(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Image.asset(
                  logoSyz,
                  color: Colors.white,
                  width: context.width * 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}