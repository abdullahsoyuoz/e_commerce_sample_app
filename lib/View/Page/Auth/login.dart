import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
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
  const LoginPage({Key key, this.onLoginPressed}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _animationController;

  TextEditingController _emailController;
  TextEditingController _passwordController;

  FocusNode _emailFocus;
  FocusNode _passwordFocus;

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
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.width,
                  height: 150,
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: context.padding.top),
                  color: AppColors.orange,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: LogoWidget(
                              size: context.width * 0.15,
                              color: AppColors.black.shade300),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: context.width * 0.5,
                                minWidth: context.width * 0.5,
                              ),
                              child: Text(
                                languageConverter(context, 'login')
                                    .toUpperCase(),
                                textAlign: TextAlign.start,
                                style: getAccentBoldStyle(),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: context.width,
                  height: 300,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Divider(
                      thickness: .1,
                      height: 0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.apple),
                              iconSize: 40,
                              splashColor: AppColors.red.shade300,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.google),
                              iconSize: 40,
                              splashColor: AppColors.red.shade300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: .1,
                      height: 0,
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: BouncingWidget(
                          onPressed: () {
                            // widget.onLoginPressed.call();
                          },
                          child: Text(
                              languageConverter(context, 'forgetPassword'),
                              textAlign: TextAlign.center,
                              style: getSpacingStyle()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: BouncingWidget(
                          onPressed: () {
                            widget.onLoginPressed.call();
                          },
                          child: Text(
                              languageConverter(context, 'notYetRegister'),
                              textAlign: TextAlign.center,
                              style: getSpacingStyle()),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
                  const Icon(
                    LineIcons.at,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        style: getTextFieldStyle(context),
                        decoration: getAuthInputDecoration(
                            languageConverter(context, 'yourEmail'),
                            Provider.of<ThemeChanger>(context, listen: false)
                                .isDark()),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(33),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (!string.isEmail()) {
                            return languageConverter(
                                context, 'yourEmailValidation');
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
                  const Icon(
                    LineIcons.fingerprint,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        style: getTextFieldStyle(context),
                        decoration: getAuthInputDecoration(
                            languageConverter(context, 'yourPassword'),
                            Provider.of<ThemeChanger>(context, listen: false)
                                .isDark()),
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        maxLines: 1,
                        textInputAction: TextInputAction.done,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(33),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (!string.isPasswordEasy()) {
                            return languageConverter(
                                context, 'yourPasswordValidation');
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
              if (_formKey.currentState.validate()) {
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
              Timer(const Duration(milliseconds: 1000), () {
                Navigator.push(
                    context, fadeRouteBuilder(context, const HomePage()));
              });
            },
            child: SizedBox.expand(
              child: ColoredBox(
                color: Colors.transparent,
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 30,
                      minHeight: 30,
                    ),
                    child: FittedBox(
                        child: Text(
                      languageConverter(context, 'submit').toUpperCase(),
                      style: getAccentStyle()
                    )),
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
