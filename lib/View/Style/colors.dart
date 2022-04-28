import 'package:flutter/material.dart';

extension AppColorScheme on ColorScheme {
  Color get success => AppColors.green;
  Color get info => AppColors.blue;
  Color get warning => AppColors.orange;
  Color get danger => AppColors.red;
  Color get main => AppColors.purple;
  Color get backgroundPrimary =>  Colors.white;
  Color get backgroundSecondary =>  Colors.grey.shade100;
  Color get foregroundPrimary => Colors.black;
  Color get foregroundSecondary => AppColors.grey.shade500;
}

// class AppColorSchemeLight extends ColorScheme{
//   const AppColorSchemeLight() : super.light();
//   Color get success => AppColors.green;
//   Color get info => AppColors.blue;
//   Color get warning => AppColors.orange;
//   Color get danger => AppColors.red;
//   Color get main => AppColors.purple;
//   Color get backgroundPrimary =>  Colors.white;
//   Color get backgroundSecondary =>  Colors.grey.shade100;
//   Color get foregroundPrimary => Colors.black;
//   Color get foregroundSecondary => AppColors.grey.shade500;
// }

// class AppColorSchemeDark extends ColorScheme{
//   const AppColorSchemeDark() : super.dark();
//   Color get success => AppColors.green.shade100;
//   Color get info => AppColors.blue.shade100;
//   Color get warning => AppColors.orange.shade100;
//   Color get danger => AppColors.red.shade100;
//   Color get main => AppColors.purple.shade100;
//   Color get backgroundPrimary => Colors.black;
//   Color get backgroundSecondary => AppColors.grey.shade500;
//   Color get foregroundPrimary =>  Colors.white;
//   Color get foregroundSecondary =>  Colors.grey.shade100;
// }

class AppColors {
  static MaterialColor orange = MaterialColor(0xffff9000, orangecnf);
  static MaterialColor yellow = MaterialColor(0xfffff400, yellowcnf);
  static MaterialColor green = MaterialColor(0xff367833, greencnf);
  static MaterialColor turquaz = MaterialColor(0xff194D68, turquazcnf);
  static MaterialColor blue = MaterialColor(0xff003e7d, bluecnf);
  static MaterialColor purple = MaterialColor(0xff3b185f, purplecnf);
  static MaterialColor red = MaterialColor(0xffFF0000, redcnf);
  static MaterialColor grey = MaterialColor(0xff6b6e74, greyscalecnf);
}

class AppBaseColors {
  static Color greyscaleS1 = const Color(0xffDDDDDD);
  static Color greyscaleS2 = const Color(0xff9C9DA0);
  static Color greyscaleS3 = const Color(0xff393E46);
  static Color greyscaleS4 = const Color(0xff27292C);
  static Color greyscaleS5 = const Color(0xFF141414);

  static Color orangeS1 = const Color(0xffFFA000);
  static Color orangeS2 = const Color(0xffFF9000);
  static Color orangeS3 = const Color(0xffE27E12);
  static Color orangeLight = const Color(0xffFFB433);

  static Color yellowS1 = const Color(0xffFFFF5C);
  static Color yellowS2 = const Color(0xffFFF400);
  static Color yellowS3 = const Color(0xffE8DE00);
  static Color yellowLight = const Color(0xffFFFFAD);

  static Color greenS1 = const Color(0xff88C158);
  static Color greenS2 = const Color(0xff367833);
  static Color greenS3 = const Color(0xff1E5128);
  static Color greenLight = const Color(0xffAED969);

  static Color turquazS1 = const Color(0xff40A3C4);
  static Color turquazS2 = const Color(0xff1E5F74);
  static Color turquazS3 = const Color(0xff194D68);
  static Color turquazLight = const Color(0xff96CCDF);

  static Color blueS1 = const Color(0xff3D7CBE);
  static Color blueS2 = const Color(0xff1C5A9A);
  static Color blueS3 = const Color(0xff062F6A);
  static Color blueLight = const Color(0xffA5D4E3);

  static Color purpleS1 = const Color(0xff764F9E);
  static Color purpleS2 = const Color(0xff3B185F);
  static Color purpleS3 = const Color(0xff2A0944);
  static Color purpleLight = const Color(0xffCCB3E6);

  static Color redS1 = const Color(0xffFF4545);
  static Color redS2 = const Color(0xffFF0000);
  static Color redS3 = const Color(0xffBF0016);
  static Color redLight = const Color(0xffFF6666);

  static Color paletteGreenS1 = const Color(0xff387d7a);
  static Color paletteGreenS2 = const Color(0xff32936f);
  static Color paletteGreenS3 = const Color(0xff26a96c);
}

Map<int, Color> greyscalecnf = {
  100: AppBaseColors.greyscaleS1,
  200: AppBaseColors.greyscaleS2,
  300: AppBaseColors.greyscaleS3,
  400: AppBaseColors.greyscaleS4,
  500: AppBaseColors.greyscaleS5,
  600: Colors.white,
  700: Colors.white,
  800: Colors.white,
  900: Colors.white
};

Map<int, Color> orangecnf = {
  50: AppBaseColors.orangeLight,
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

Map<int, Color> yellowcnf = {
  50: AppBaseColors.yellowLight,
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

Map<int, Color> greencnf = {
  50: AppBaseColors.greenLight,
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

Map<int, Color> turquazcnf = {
  50: AppBaseColors.turquazLight,
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

Map<int, Color> bluecnf = {
  50: AppBaseColors.blueLight,
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

Map<int, Color> purplecnf = {
  50: AppBaseColors.purpleLight,
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

Map<int, Color> redcnf = {
  50: AppBaseColors.redLight,
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
