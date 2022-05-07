import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple.shade400,
  colorScheme: ColorScheme.light(
    background: AppColors.grey.shade100,
    primaryContainer: AppColors.grey.shade200,
    secondaryContainer: AppColors.grey.shade300,
  ),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: AppColors.grey.shade100,
  hintColor: AppColors.black.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.purple.shade400,
  splashFactory: InkRipple.splashFactory,
  dividerColor: AppColors.black.shade100,
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    floatingLabelStyle: TextStyle(color: Colors.white),
  ),
  textTheme: GoogleFonts.workSansTextTheme().copyWith(
    bodyText2: GoogleFonts.workSans(
      fontSize: 14,
      color: Colors.black,
    ),
    subtitle2: GoogleFonts.workSans(
      fontSize: 14,
      color: Colors.white,
      height: 1.5,
      backgroundColor: Colors.black,
      wordSpacing: 1,
    ),
  ),
  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 10,
    margin: EdgeInsets.zero,
    shape: RoundedRectangleBorder(borderRadius: appRadius()),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
    size: 30,
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
  // ---------------------------------------------------- BUTTON
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade400,
    foregroundColor: Colors.white,
    splashColor: AppColors.red.shade400,
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
      overlayColor: MaterialStateProperty.all(AppColors.purple.shade400),
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
      overlayColor: MaterialStateProperty.all(AppColors.purple.shade400),
      splashFactory: InkRipple.splashFactory,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);
