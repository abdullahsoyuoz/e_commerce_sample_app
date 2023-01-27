// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/Controller/Provider/theme_provider.dart';
import 'package:sepet_demo/View/Painter/register_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback? onRegisterPressed;
  const RegisterPage({Key? key, this.onRegisterPressed})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late AnimationController _animationController;
  double lastAnimationState = 0;

   TextEditingController? _nameController;
   TextEditingController? _phoneNumberController;
   TextEditingController? _emailController;
   TextEditingController? _passwordController;

   FocusNode? _nameFocus;
   FocusNode? _phoneNumberFocus;
   FocusNode? _emailFocus;
   FocusNode? _passwordFocus;

  @override
  void initState() {
    // INITIALIZATION
    super.initState();
    _animationController = AnimationController(
      upperBound: 5,
      lowerBound: 0,
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    //
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    //
    _nameFocus = FocusNode();
    _phoneNumberFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    // LISTENERS
    //
    _nameController!.addListener(() => _validation());
    _phoneNumberController!.addListener(() => _validation());
    _emailController!.addListener(() => _validation());
    _passwordController!.addListener(() => _validation());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    // _nameController.dispose();
    // _phoneNumberController.dispose();
    // _emailController.dispose();
    // _passwordController.dispose();
    // _nameFocus.dispose();
    // _phoneNumberFocus.dispose();
    // _emailFocus.dispose();
    // _passwordFocus.dispose();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.width,
                  height: 150,
                  padding: EdgeInsets.only(
                      left: 20, right: 20, top: context.padding.top),
                  color: AppColors.turquaz,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: LogoWidget(size: context.width * 0.15),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: ConstrainedBox(
                              constraints: BoxConstraints(
                                maxWidth: context.width * 0.5,
                                minWidth: context.width * 0.5,
                              ),
                              child: Text(
                                languageConverter(context, 'register')!.toUpperCase(),
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
                  height: 500,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      SizedBox.expand(
                        child: CustomPaint(
                          painter: RegisterPainter(
                            animation: _animationController,
                          ),
                        ),
                      ),
                      buildInputs(context)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: BouncingWidget(
                      onPressed: () {
                        widget.onRegisterPressed!.call();
                      },
                      child: Text(
                        languageConverter(context, 'iWantLogin')!,
                        style: getSpacingStyle()
                      ),
                    ),
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
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Icon(
                    LineIcons.user,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        style: getTextFieldStyle(context),
                        decoration: getAuthInputDecoration(languageConverter(context, 'yourName'), Provider.of<ThemeChanger>(context, listen: false).isDark()!),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(21),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (string!.length < 3) {
                            return languageConverter(context, 'yourEmailValidation');
                          } else {
                            return null;
                          }
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
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  const Icon(
                    LineIcons.mobilePhone,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        focusNode: _phoneNumberFocus,
                        style: getTextFieldStyle(context),
                        decoration: getAuthInputDecoration(languageConverter(context, 'yourContactNumber'), Provider.of<ThemeChanger>(context, listen: false).isDark()!),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (string) {
                          if (string!.length != 11) {
                            return languageConverter(context, 'yourContactNumberValidation');
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
                        decoration: getAuthInputDecoration(languageConverter(context, 'yourEmail'), Provider.of<ThemeChanger>(context, listen: false).isDark()!),
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(33),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (!string!.isEmail()) {
                            return languageConverter(context, 'yourEmailValidation');
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
                        decoration: getAuthInputDecoration(languageConverter(context, 'yourPassword'), Provider.of<ThemeChanger>(context, listen: false).isDark()!),
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
                            return languageConverter(context, 'yourPasswordValidation');
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
                _animationController.animateTo(5);
              } else {
                _validation().then((value) =>
                    _animationController.animateBack(value.toDouble()));
              }
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
                    child:  FittedBox(
                        child: Text(
                      languageConverter(context, 'submit')!.toUpperCase(),
                      style: getAccentStyle(),
                    )),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Divider(thickness: .1, height: 0,),
      ],
    );
  }

  Future<int> _validation() async {
    if (_nameController!.text.length > 2 &&
        _phoneNumberController!.text.length == 11 &&
        _emailController!.text.isEmail() &&
        _passwordController!.text.isPasswordEasy()) {
      _animationController.animateTo(4);
      return 4;
    }
    if (_nameController!.text.length > 2 &&
        _phoneNumberController!.text.length == 11 &&
        _emailController!.text.isEmail()) {
      _animationController.animateTo(3);
      return 3;
    }
    if (_nameController!.text.length > 2 &&
        _phoneNumberController!.text.length == 11) {
      _animationController.animateTo(2);
      return 2;
    }
    if (_nameController!.text.length > 2) {
      _animationController.animateTo(1);
      return 1;
    } else {
      _animationController.animateTo(0);
      return 0;
    }
  }
}
