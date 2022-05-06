import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Page/User/home.dart';
import 'package:sepet_demo/View/Painter/login_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';
import 'package:sepet_demo/View/Style/route_builder.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onLoginPressed;
  const LoginPage({Key? key, required this.onLoginPressed}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AnimationController _animationController;

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

  @override
  void initState() {
    _animationController = AnimationController(
      upperBound: 3,
      lowerBound: 0,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    //
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    //
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    // LISTENERS
    _animationController.addListener(() {});
    _emailController.addListener(() => _validation());
    _passwordController.addListener(() => _validation());

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    // _emailController.dispose();
    // _passwordController.dispose();
    // _emailFocus.dispose();
    // _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SizedBox.expand(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  vertical: context.padding.top * 1, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: LogoWidget(size: context.width * 0.15),
                  ),
                  ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: context.width * 0.35,
                        minWidth: context.width * 0.35,
                      ),
                      child: const FittedBox(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Giriş Yap',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ))),
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(color: Colors.black, blurRadius: 5)
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: context.width * 0.75,
                          height: context.width * 0.75,
                          decoration: BoxDecoration(
                            color: AppColors.black.shade300
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              SizedBox.expand(
                                child: CustomPaint(
                                  painter: LoginPainter(
                                    animation: _animationController,
                                  ),
                                ),
                              ),
                              buildInputs(context),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: context.width * 0.75,
                              minWidth: context.width * 0.75,
                              maxHeight: 20,
                              minHeight: 20,
                            ),
                            child: const FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Text(
                                'veya',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  letterSpacing: 10,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Expanded(
                                  child: Divider(
                                thickness: 0.5,
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FontAwesomeIcons.apple),
                                  iconSize: 45,
                                  splashColor: AppColors.red,
                                  highlightColor: Colors.transparent,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(FontAwesomeIcons.google),
                                  iconSize: 45,
                                  splashColor: AppColors.red,
                                  highlightColor: Colors.transparent,
                                  color: Colors.white,
                                ),
                              ),
                              const Expanded(
                                  child: Divider(
                                thickness: 0.5,
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.75,
                          minWidth: context.width * 0.75,
                          maxHeight: 20,
                          minHeight: 20,
                        ),
                        child: FittedBox(
                          child: BouncingWidget(
                            onPressed: () {
                              // widget.onLoginPressed.call();
                            },
                            child: const Text(
                              'şifremi unuttum',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                letterSpacing: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: context.width * 0.75,
                          minWidth: context.width * 0.75,
                          maxHeight: 20,
                          minHeight: 20,
                        ),
                        child: FittedBox(
                          child: BouncingWidget(
                            onPressed: () {
                              widget.onLoginPressed.call();
                            },
                            child: const Text(
                              'henüz bize katılmadın mı?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                letterSpacing: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildInputs(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Icon(
                    LineIcons.at,
                    color: _emailFocus.hasFocus
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        style: textfieldstyle,
                        decoration: getAuthInputDecoration('e-mail'),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(33),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (!string!.isEmail()) {
                            return 'e-mail adresiniz doğrulanamadı.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Icon(
                    LineIcons.fingerprint,
                    color: _passwordFocus.hasFocus
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        style: textfieldstyle,
                        decoration: getAuthInputDecoration('parola'),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(33),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (!string!.isPasswordEasy()) {
                            return 'parolanız doğrulanamadı.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: BouncingWidget(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                FocusScope.of(context).unfocus();
                _animationController.animateTo(3).whenComplete(() {
                  Timer(const Duration(milliseconds: 300), () {
                    Navigator.push(
                        context, fadeRouteBuilder(context, const HomePage()));
                  });
                });
              } else {
                _validation().then((value) =>
                    _animationController.animateBack(value.toDouble()));
              }

              Navigator.push(
                  context, fadeRouteBuilder(context, const HomePage()));
            },
            child: SizedBox.expand(
              child: ColoredBox(
                color: Colors.transparent,
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.width * 0.1,
                      minWidth: context.width * 0.1,
                    ),
                    child: const FittedBox(
                      child: Icon(
                        FontAwesomeIcons.arrowRight,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<int> _validation() async {
    if (_emailController.text.isEmail() &&
        _passwordController.text.isPasswordEasy()) {
      _animationController.animateTo(2);
      return 2;
    }
    if (_emailController.text.isEmail()) {
      _animationController.animateTo(1);
      return 1;
    } else {
      _animationController.animateTo(0);
      return 0;
    }
  }
}
