import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/View/Style/colors.dart';

ThemeData appLightTheme = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: AppColors.purple,
  colorScheme: ColorScheme.light(
    primaryContainer: AppColors.grey.shade100,
    secondaryContainer: AppColors.grey.shade200,
  ),
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
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.red.shade300, width: 4)),
    labelColor: Colors.black,
    labelPadding: const EdgeInsets.symmetric(vertical: 3),
    unselectedLabelColor: Colors.black.withOpacity(.3),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.grey.shade200,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    foregroundColor: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
  dividerColor: Colors.grey.shade300,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade200,
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
  colorScheme: const ColorScheme.dark().copyWith(
    primaryContainer: AppColors.grey.shade400,
    secondaryContainer: AppColors.grey.shade500,
  ),
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
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(borderSide: BorderSide(color: AppColors.red.shade300, width: 4)),
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
  dividerColor: AppColors.grey.shade200,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColors.purple.shade200,
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
