import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/View/Page/Auth/login.dart';
import 'package:sepet_demo/View/Page/Auth/register.dart';
import 'package:sepet_demo/View/Painter/auth_background_painter.dart';

class AuthMainPage extends StatefulWidget {
  const AuthMainPage({Key? key}) : super(key: key);

  @override
  _AuthMainPageState createState() => _AuthMainPageState();
}

class _AuthMainPageState extends State<AuthMainPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  ValueNotifier<bool> showRegisterPage = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: showRegisterPage,
      builder: (context, value, child) {
        return SizedBox.expand(
          child: ColoredBox(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: AuthBackgroundPainter(animation: _animationController, isDark: Provider.of<ThemeChanger>(context, listen:  false).isDark()),
                ),
                Opacity(
                  opacity: 0.95,
                  child: PageTransitionSwitcher(
                    transitionBuilder:
                        (child, primaryAnimation, secondaryAnimation) {
                      return SharedAxisTransition(
                        animation: primaryAnimation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        fillColor: Colors.transparent,
                        child: child,
                      );
                    },
                    reverse: value,
                    child: value
                        ? RegisterPage(
                            key: const ValueKey('RegisterPage'),
                            onRegisterPressed: () {
                              showRegisterPage.value = false;
                              _animationController.reverse();
                            },
                          )
                        : LoginPage(
                            key: const ValueKey('LoginPage'),
                            onLoginPressed: () {
                              showRegisterPage.value = true;
                              _animationController.forward();
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
