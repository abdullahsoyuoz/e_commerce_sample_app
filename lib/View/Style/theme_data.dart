import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple,
  colorScheme: const ColorScheme.light().copyWith(
    background: Colors.black
  ),
  scaffoldBackgroundColor: Colors.white,
  backgroundColor: Colors.white,
  hintColor: AppColors.grey.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.red,
  splashFactory: InkRipple.splashFactory,
  textTheme: GoogleFonts.readexProTextTheme().copyWith(
    titleLarge: const TextStyle(
      fontSize: 21,
      color: Colors.white,
    ),
    titleMedium: const TextStyle(
      fontSize: 17,
      color: Colors.white,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.purple,
    foregroundColor: AppColors.purple.shade100,
    iconTheme: const IconThemeData(
      color: Colors.white
    )
  ),
  dividerColor: Colors.grey.shade300,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade300,
    foregroundColor: AppColors.purple.shade100,
    splashColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black
  ) ,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(Colors.black),
      splashFactory: InkRipple.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.red)
    ),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.red,
  ),
);

ThemeData appDarkTheme = ThemeData.dark().copyWith(
  brightness: Brightness.dark,
  primaryColor: AppColors.orange,
  colorScheme: const ColorScheme.dark().copyWith(
    background: Colors.white
  ),
  scaffoldBackgroundColor: const Color(0xff121212),
  backgroundColor: const Color(0xff121212),
  hintColor: AppColors.grey.shade100,
  highlightColor: Colors.transparent,
  splashColor: AppColors.red,
  splashFactory: InkRipple.splashFactory,
  textTheme: GoogleFonts.readexProTextTheme().copyWith(
    titleLarge: const TextStyle(
      fontSize: 21,
      color: Colors.black,
    ),
    titleMedium: const TextStyle(
      fontSize: 17,
      color: Colors.black,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: AppColors.grey.shade500,
    iconTheme: const IconThemeData(
      color: Colors.white
    ),
  ),
  dividerColor: Colors.red,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.grey.shade500,
    foregroundColor: AppColors.grey,
    splashColor: Colors.white,
  ),
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
  ),
  iconTheme: const IconThemeData(
    color: Colors.black
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))),
      elevation: MaterialStateProperty.all(0),
      backgroundColor: MaterialStateProperty.all(Colors.black),
      splashFactory: InkRipple.splashFactory,
      overlayColor: MaterialStateProperty.all(AppColors.red)
    ),
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
