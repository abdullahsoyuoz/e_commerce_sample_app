import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple.shade300,
  colorScheme: ColorScheme.light(
    background: AppColors.grey.shade100,
    primaryContainer: AppColors.grey.shade200,
    secondaryContainer: AppColors.grey.shade300,
  ),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: AppColors.grey.shade100,
  hintColor: AppColors.black.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.purple.shade300,
  splashFactory: InkRipple.splashFactory,
  dividerColor: AppColors.black.shade100,
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    floatingLabelStyle: TextStyle(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontFamily: 'Futura',
      fontStyle: FontStyle.normal,
      color: Colors.black,
      fontSize: 14,
    ),
    subtitle2: TextStyle(
      fontFamily: 'Futura',
      fontStyle: FontStyle.normal,
      color: Colors.white,
      fontSize: 14,
      height: 1.5,
      backgroundColor: Colors.black,
      wordSpacing: 1,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
    size: 30,
  ),

  // ------------------------------------------------------------------------------------------------ WIDGET ----------

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 10,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: appRadius()),
  ),

  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.red.shade300, width: 4)),
    labelColor: Colors.black,
    labelPadding: const EdgeInsets.symmetric(vertical: 3),
    unselectedLabelColor: Colors.black.withOpacity(.3),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.purple.shade300,
    actionTextColor: Colors.white,
    contentTextStyle: const TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: appRadius())
  ),

  // ------------------------------------------------------------------------------------------------ BUTTON ----------

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade300,
    foregroundColor: Colors.white,
    splashColor: AppColors.red.shade300,
    elevation: 10,
  ),

  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      elevation: MaterialStateProperty.all(10),
      textStyle: MaterialStateProperty.all(const TextStyle()),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      backgroundColor: MaterialStateProperty.all(Colors.white),
      splashFactory: InkRipple.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.purple.shade300),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      side: MaterialStateProperty.all(
          const BorderSide(color: Colors.black, width: 1)),
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(AppColors.purple.shade300),
      splashFactory: InkRipple.splashFactory,
    ),
  ),
);
