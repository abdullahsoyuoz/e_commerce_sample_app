import 'package:flutter/material.dart';

extension AppColorScheme on ColorScheme {
  Color get success => AppColors.green;
  Color get info => AppColors.blue;
  Color get warning => AppColors.orange;
  Color get danger => AppColors.red;
  Color get main => AppColors.purple;
  Color get backgroundPrimary => Colors.white;
  Color get backgroundSecondary => Colors.grey.shade100;
  Color get foregroundPrimary => Colors.black;
  Color get foregroundSecondary => AppColors.grey.shade300;
}

class AppColors {
  static MaterialColor grey = MaterialColor(0xffE6E6E6, _materialGrey);
  static MaterialColor black = MaterialColor(0xff272A30, _materialBlack);
  static MaterialColor orange = MaterialColor(0xffFFB433, _materialOrange);
  static MaterialColor yellow = MaterialColor(0xffFFFA2E, _materialYellow);
  static MaterialColor green = MaterialColor(0xff88C158, _materialGreen);
  static MaterialColor turquaz = MaterialColor(0xff2F819C, _materialTurquaz);
  static MaterialColor blue = MaterialColor(0xff1C5A9A, _materialBlue);
  static MaterialColor purple = MaterialColor(0xff764F9E, _materialPurple);
  static MaterialColor red = MaterialColor(0xffFF4545, _materialRed);
}

class AppBaseColors {
  static Color greyS1 = const Color(0xffFBFBFB);
  static Color greyS2 = const Color(0xffE6E6E6);
  static Color greyS3 = const Color(0xffDDDDDD);

  static Color blackS1 = const Color(0xff3E434C);
  static Color blackS2 = const Color(0xff272A30);
  static Color blackS3 = const Color(0xff101214);

  static Color orangeS1 = const Color(0xffF5D7A4);
  static Color orangeS2 = const Color(0xffFFB433);
  static Color orangeS3 = const Color(0xffFF9000);

  static Color yellowS1 = const Color(0xffFFFF88);
  static Color yellowS2 = const Color(0xffFFFA2E);
  static Color yellowS3 = const Color(0xffFFF400);

  static Color greenS1 = const Color(0xffCBEC96);
  static Color greenS2 = const Color(0xff88C158);
  static Color greenS3 = const Color(0xff367833);

  static Color turquazS1 = const Color(0xff94CFE4);
  static Color turquazS2 = const Color(0xff2F819C);
  static Color turquazS3 = const Color(0xff194D68);

  static Color blueS1 = const Color(0xff71A8D1);
  static Color blueS2 = const Color(0xff1C5A9A);
  static Color blueS3 = const Color(0xff062F6A);

  static Color purpleS1 = const Color(0xffCCB3E6);
  static Color purpleS2 = const Color(0xff764F9E);
  static Color purpleS3 = const Color(0xff3B185F);

  static Color redS1 = const Color(0xffFFA3A3);
  static Color redS2 = const Color(0xffFF4545);
  static Color redS3 = const Color(0xffE60000);
}

Map<int, Color> _materialGrey = {
  50: Colors.white,
  100: AppBaseColors.greyS1,
  200: AppBaseColors.greyS2,
  300: AppBaseColors.greyS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialBlack = {
  50: Colors.white,
  100: AppBaseColors.blackS1,
  200: AppBaseColors.blackS2,
  300: AppBaseColors.blackS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialOrange = {
  50: Colors.white,
  100: AppBaseColors.orangeS1,
  200: AppBaseColors.orangeS2,
  300: AppBaseColors.orangeS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialYellow = {
  50: Colors.white,
  100: AppBaseColors.yellowS1,
  200: AppBaseColors.yellowS2,
  300: AppBaseColors.yellowS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialGreen = {
  50: Colors.white,
  100: AppBaseColors.greenS1,
  200: AppBaseColors.greenS2,
  300: AppBaseColors.greenS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialTurquaz = {
  50: Colors.white,
  100: AppBaseColors.turquazS1,
  200: AppBaseColors.turquazS2,
  300: AppBaseColors.turquazS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialBlue = {
  50: Colors.white,
  100: AppBaseColors.blueS1,
  200: AppBaseColors.blueS2,
  300: AppBaseColors.blueS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialPurple = {
  50: Colors.white,
  100: AppBaseColors.purpleS1,
  200: AppBaseColors.purpleS2,
  300: AppBaseColors.purpleS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialRed = {
  50: Colors.white,
  100: AppBaseColors.redS1,
  200: AppBaseColors.redS2,
  300: AppBaseColors.redS3,
  400: Colors.white,
  500: Colors.white,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};
