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
  Color get foregroundSecondary => AppColors.grey.shade500;
}

class AppColors {
  static MaterialColor grey = MaterialColor(0xffDDDDDD, _materialGrey);
  static MaterialColor black = MaterialColor(0xff171717, _materialBlack);
  static MaterialColor orange = MaterialColor(0xffFFB433, _materialOrange);
  static MaterialColor yellow = MaterialColor(0xffFFFA2E, _materialYellow);
  static MaterialColor green = MaterialColor(0xffAED969, _materialGreen);
  static MaterialColor turquaz = MaterialColor(0xff6BB8D2, _materialTurquaz);
  static MaterialColor blue = MaterialColor(0xff3D7CBE, _materialBlue);
  static MaterialColor purple = MaterialColor(0xff764F9E, _materialPurple);
  static MaterialColor red = MaterialColor(0xffFF4545, _materialRed);
}

class AppBaseColors {
  static Color greyS1 = const Color(0xffFBFBFB);
  static Color greyS2 = const Color(0xffE6E6E6);
  static Color greyS3 = const Color(0xffDDDDDD);
  static Color greyS4 = const Color(0xffBDBDBF);
  static Color greyS5 = const Color(0xFF9C9DA0);

  static Color blackS1 = const Color(0xff848B9A);
  static Color blackS2 = const Color(0xff343840);
  static Color blackS3 = const Color(0xff27292C);
  static Color blackS4 = const Color(0xFF171717);
  static Color blackS5 = const Color(0xFF090c08);

  static Color orangeLight = const Color(0xffFFF6E5);
  static Color orangeS1 = const Color(0xffFFDA99);
  static Color orangeS2 = const Color(0xffFFC561);
  static Color orangeS3 = const Color(0xffFFB433);
  static Color orangeS4 = const Color(0xffFFA000);
  static Color orangeS5 = const Color(0xffFF9000);

  static Color yellowLight = const Color(0xffFFFFE5);
  static Color yellowS1 = const Color(0xffFFFF99);
  static Color yellowS2 = const Color(0xffFFFF5C);
  static Color yellowS3 = const Color(0xffFFFA2E);
  static Color yellowS4 = const Color(0xffFFFF00);
  static Color yellowS5 = const Color(0xffFFF400);

  static Color greenLight = const Color(0xffF5FFE5);
  static Color greenS1 = const Color(0xffE8FFC2);
  static Color greenS2 = const Color(0xffCBEC96);
  static Color greenS3 = const Color(0xffAED969);
  static Color greenS4 = const Color(0xff88C158);
  static Color greenS5 = const Color(0xff367833);

  static Color turquazLight = const Color(0xffE9F7FC);
  static Color turquazS1 = const Color(0xffBDE6F5);
  static Color turquazS2 = const Color(0xff96CFE4);
  static Color turquazS3 = const Color(0xff6BB8D2);
  static Color turquazS4 = const Color(0xff2F819C);
  static Color turquazS5 = const Color(0xff194D68);

  static Color blueLight = const Color(0xffE4F6FC);
  static Color blueS1 = const Color(0xffCBEBF6);
  static Color blueS2 = const Color(0xff71A8D1);
  static Color blueS3 = const Color(0xff3D7CBE);
  static Color blueS4 = const Color(0xff1C5A9A);
  static Color blueS5 = const Color(0xff062F6A);

  static Color purpleLight = const Color(0xffF2EAFB);
  static Color purpleS1 = const Color(0xffE2CFF7);
  static Color purpleS2 = const Color(0xffCCB3E6);
  static Color purpleS3 = const Color(0xff764F9E);
  static Color purpleS4 = const Color(0xff59248F);
  static Color purpleS5 = const Color(0xff2A0944);

  static Color redLight = const Color(0xffFFE5E5);
  static Color redS1 = const Color(0xffFFA3A3);
  static Color redS2 = const Color(0xffFF6666);
  static Color redS3 = const Color(0xffFF4545);
  static Color redS4 = const Color(0xffE60000);
  static Color redS5 = const Color(0xffBF0016);
}

Map<int, Color> _materialGrey = {
  50: Colors.white,
  100: AppBaseColors.greyS1,
  200: AppBaseColors.greyS2,
  300: AppBaseColors.greyS3,
  400: AppBaseColors.greyS4,
  500: AppBaseColors.greyS5,
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
  400: AppBaseColors.blackS4,
  500: AppBaseColors.blackS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialOrange = {
  50: AppBaseColors.orangeLight,
  100: AppBaseColors.orangeS1,
  200: AppBaseColors.orangeS2,
  300: AppBaseColors.orangeS3,
  400: AppBaseColors.orangeS4,
  500: AppBaseColors.orangeS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialYellow = {
  50: AppBaseColors.yellowLight,
  100: AppBaseColors.yellowS1,
  200: AppBaseColors.yellowS2,
  300: AppBaseColors.yellowS3,
  400: AppBaseColors.yellowS4,
  500: AppBaseColors.yellowS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialGreen = {
  50: AppBaseColors.greenLight,
  100: AppBaseColors.greenS1,
  200: AppBaseColors.greenS2,
  300: AppBaseColors.greenS3,
  400: AppBaseColors.greenS4,
  500: AppBaseColors.greenS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialTurquaz = {
  50: AppBaseColors.turquazLight,
  100: AppBaseColors.turquazS1,
  200: AppBaseColors.turquazS2,
  300: AppBaseColors.turquazS3,
  400: AppBaseColors.turquazS4,
  500: AppBaseColors.turquazS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialBlue = {
  50: AppBaseColors.blueLight,
  100: AppBaseColors.blueS1,
  200: AppBaseColors.blueS2,
  300: AppBaseColors.blueS3,
  400: AppBaseColors.blueS4,
  500: AppBaseColors.blueS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialPurple = {
  50: AppBaseColors.purpleLight,
  100: AppBaseColors.purpleS1,
  200: AppBaseColors.purpleS2,
  300: AppBaseColors.purpleS3,
  400: AppBaseColors.purpleS4,
  500: AppBaseColors.purpleS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> _materialRed = {
  50: AppBaseColors.redLight,
  100: AppBaseColors.redS1,
  200: AppBaseColors.redS2,
  300: AppBaseColors.redS3,
  400: AppBaseColors.redS4,
  500: AppBaseColors.redS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};
