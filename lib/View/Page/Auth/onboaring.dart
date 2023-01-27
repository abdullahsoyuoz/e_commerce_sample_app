// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Page/Auth/auth.dart';
import 'package:sepet_demo/View/Painter/onboarding_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/View/onboard_views.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
   AnimationController? _animationController;
   PageController? _pageController;
  int onboardIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      upperBound: 3,
      lowerBound: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController!.dispose();
    _pageController!.dispose();
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
                  painter: OnboardingPainter(animation: _animationController),
                ),
              ),
              PageView.builder(
                onPageChanged: (value) {
                  _animationController!.animateTo(value.toDouble());
                },
                controller: _pageController,
                itemCount: onBoardList.length,
                itemBuilder: (context, index) {
                  return onBoardList[index];
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: IconButton(
                    splashColor: AppColors.purple,
                    icon: const SizedBox(),
                    onPressed: () {
                      if (_animationController!.value < 3) {
                        _pageController!.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.ease);
                      } else {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const AuthMainPage()));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
