import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';

ThemeData appPurpleTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple,
  colorScheme: ColorScheme.light(
    background: AppColors.purple.shade100,
    primaryContainer: AppColors.grey.shade200,
    secondaryContainer: AppColors.grey.shade300,
  ),
  scaffoldBackgroundColor: AppColors.purple.shade50,
  backgroundColor: Colors.white,
  hintColor: AppColors.black.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.red,
  splashFactory: InkRipple.splashFactory,
  dividerColor: AppColors.black.shade100,
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
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.purple.shade200,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    foregroundColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
  // ---------------------------------------------------- BUTTON
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade300,
    foregroundColor: Colors.black,
    splashColor: AppColors.red,
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
          const BorderSide(color: Colors.black, width: 1)),
      elevation: MaterialStateProperty.all(0),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      overlayColor: MaterialStateProperty.all(AppColors.red),
      splashFactory: InkRipple.splashFactory,
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);