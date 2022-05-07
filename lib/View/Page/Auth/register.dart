import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:regexpattern/regexpattern.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Painter/register_painter.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';
import 'package:sepet_demo/View/Style/input_decorations.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
import 'package:sepet_demo/View/Widget/bouncing_widget.dart';
import 'package:sepet_demo/View/Widget/logo.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onRegisterPressed;
  const RegisterPage({Key? key, required this.onRegisterPressed})
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

  late final TextEditingController _nameController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  late final FocusNode _nameFocus;
  late final FocusNode _phoneNumberFocus;
  late final FocusNode _emailFocus;
  late final FocusNode _passwordFocus;

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
    _animationController.addListener(() {});
    //
    _nameController.addListener(() => _validation());
    _phoneNumberController.addListener(() => _validation());
    _emailController.addListener(() => _validation());
    _passwordController.addListener(() => _validation());
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
                          'Bize Katıl',
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ))),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Card(
                    color: AppColors.black.shade500,
                    child: ClipRRect(
                      borderRadius: appRadius(),
                      child: SizedBox(
                        width: context.width * 0.75,
                        height: context.width * 0.75 * 1.5,
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
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
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
                            widget.onRegisterPressed.call();
                          },
                          child: const Text(
                            'giriş yapmak istiyorum',
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
                  Icon(
                    LineIcons.user,
                    color: _nameFocus.hasFocus
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _nameController,
                        focusNode: _nameFocus,
                        style: textfieldstyle,
                        decoration: getAuthInputDecoration('isim'),
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(21),
                          FilteringTextInputFormatter.singleLineFormatter
                        ],
                        validator: (string) {
                          if (string!.length < 3) {
                            return 'isim en az üç haneden oluşmalı.';
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
                  Icon(
                    LineIcons.mobilePhone,
                    color: _phoneNumberFocus.hasFocus
                        ? Colors.white
                        : Colors.white.withOpacity(.5),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        controller: _phoneNumberController,
                        focusNode: _phoneNumberFocus,
                        style: textfieldstyle,
                        decoration: getAuthInputDecoration('iletişim numarası'),
                        keyboardType: TextInputType.phone,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(11),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (string) {
                          if (string!.length != 11) {
                            return 'iletişim numarası 11 hane olmalı.';
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
                            return 'e-mail adresi doğrulanamadı.';
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
                            return 'güçlü bir parola seçiniz.';
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
    if (_nameController.text.length > 2 &&
        _phoneNumberController.text.length == 11 &&
        _emailController.text.isEmail() &&
        _passwordController.text.isPasswordEasy()) {
      _animationController.animateTo(4);
      return 4;
    }
    if (_nameController.text.length > 2 &&
        _phoneNumberController.text.length == 11 &&
        _emailController.text.isEmail()) {
      _animationController.animateTo(3);
      return 3;
    }
    if (_nameController.text.length > 2 &&
        _phoneNumberController.text.length == 11) {
      _animationController.animateTo(2);
      return 2;
    }
    if (_nameController.text.length > 2) {
      _animationController.animateTo(1);
      return 1;
    } else {
      _animationController.animateTo(0);
      return 0;
    }
  }
}
