import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

ThemeData appDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.orange,
  colorScheme: const ColorScheme.dark().copyWith(
    background: AppColors.black.shade300,
    primaryContainer: AppColors.black.shade200,
    secondaryContainer: AppColors.black.shade100,
  ),
  scaffoldBackgroundColor: AppColors.black.shade400,
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
  textTheme: GoogleFonts.workSansTextTheme().copyWith(
    bodyText2: GoogleFonts.workSans(
      fontSize: 14,
      color: Colors.white,
    ),
    subtitle2: GoogleFonts.workSans(
      color: Colors.black,
      fontSize: 14,
      height: 1.5,
      backgroundColor: Colors.white,
      wordSpacing: 1,
    ),
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
    size: 30,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: AppColors.red.shade300, width: 4)),
    labelPadding: const EdgeInsets.symmetric(vertical: 3),
    labelColor: Colors.white,
    unselectedLabelColor: Colors.white.withOpacity(.3),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.purple.shade500,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    foregroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  // ---------------------------------------------------- BUTTON
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade400,
    foregroundColor: Colors.white,
    splashColor: AppColors.black.shade100,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
      elevation: MaterialStateProperty.all(0),
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
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);
