import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple,
  colorScheme: const ColorScheme.light().copyWith(background: Colors.black),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  hintColor: AppColors.grey.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.red,
  splashFactory: InkRipple.splashFactory,
  textTheme: GoogleFonts.readexProTextTheme().copyWith(
    bodyText2: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    subtitle2: const TextStyle(
      fontSize: 14,
      color: Colors.white,
      height: 1.5,
      backgroundColor: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.grey.shade100,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
  dividerColor: Colors.grey.shade300,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
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
        overlayColor: MaterialStateProperty.all(AppColors.red)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);

ThemeData appDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.orange,
  colorScheme: const ColorScheme.dark().copyWith(background: Colors.white),
  scaffoldBackgroundColor: AppColors.grey.shade500,
  backgroundColor: Colors.black,
  hintColor: AppColors.grey.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.red,
  splashFactory: InkRipple.splashFactory,
  textTheme: GoogleFonts.readexProTextTheme().copyWith(
   bodyText2: const TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    subtitle2: const TextStyle(
      fontSize: 14,
      color: Colors.black,
      height: 1.5,
      backgroundColor: Colors.white,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  dividerColor: AppColors.grey.shade200,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
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
        overlayColor: MaterialStateProperty.all(AppColors.red)),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);

/* GOOGLE FONTS
  lexend
  readexPro
  majorMonoDisplay
  zenTokyoZoo
  josefinSans
  didactGothic
  poiretOne
  palanquin
  palanquinDark
  urbanist
  leagueSpartan
*/
