import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

ThemeData appDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.orange,
  colorScheme: const ColorScheme.dark().copyWith(
    background: AppColors.black.shade300,
    primaryContainer: AppColors.black.shade100,
    secondaryContainer: AppColors.black.shade200,
    tertiaryContainer: AppColors.black.shade300,
    error: AppColors.red.shade200,
    outline: AppColors.blue.shade100,
  ),
  scaffoldBackgroundColor: AppColors.black.shade300,
  backgroundColor: Colors.black,
  hintColor: AppColors.black.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.black.shade100,
  splashFactory: InkRipple.splashFactory,
  dividerColor: AppColors.grey.shade200,
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    floatingLabelStyle: TextStyle(color: Colors.white),
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      fontFamily: 'Futura',
      fontStyle: FontStyle.normal,
      color: Colors.white,
      fontSize: 14,
    ),
    subtitle2: TextStyle(
      color: Colors.black,
      fontFamily: 'Futura',
      fontStyle: FontStyle.normal,
      backgroundColor: Colors.white,
      fontSize: 14,
      height: 1.5,
      wordSpacing: 1,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 30,
  ),

  // ------------------------------------------------------------------------------------------------ WIDGET ----------

  cardTheme: CardTheme(
    color: AppColors.black.shade100,
    elevation: 10,
    shadowColor: Colors.black,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: appRadius()),
  ),

  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.red.shade300, width: 4)),
    labelPadding: const EdgeInsets.symmetric(vertical: 3),
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white.withOpacity(.3),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
  ),

  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.black,
    actionTextColor: Colors.white,
    contentTextStyle: const TextStyle(color: Colors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: appRadius()),
  ),

  // ------------------------------------------------------------------------------------------------ BUTTON ----------

  floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      splashColor: AppColors.black.shade100,
      elevation: 10),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      elevation: MaterialStateProperty.all(10),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.black),
      splashFactory: InkRipple.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.red),
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
          BorderSide(color: Colors.white, width: lineThickness())),
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      overlayColor: MaterialStateProperty.all(AppColors.red),
      splashFactory: InkRipple.splashFactory,
    ),
  ),
);
