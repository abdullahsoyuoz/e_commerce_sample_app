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
  static Color greyscaleS1 = const Color(0xffcccccc);
  static Color greyscaleS2 = const Color(0xff6b6e74);
  static Color greyscaleS3 = const Color(0xff393e46);
  static Color greyscaleS4 = const Color(0xFF180627);
  static Color greyscaleS5 = const Color(0xff262626);

  static Color orangeS1 = const Color(0xffffa000);
  static Color orangeS2 = const Color(0xffff9000);
  static Color orangeS3 = const Color(0xffe27e12);

  static Color yellowS1 = const Color(0xffffff00);
  static Color yellowS2 = const Color(0xfffff400);
  static Color yellowS3 = const Color(0xffe8de00);

  static Color greenS1 = const Color(0xff48963B);
  static Color greenS2 = const Color(0xff367833);
  static Color greenS3 = const Color(0xff1E5128);

  static Color turquazS1 = const Color(0xff40a3c4);
  static Color turquazS2 = const Color(0xff1e5f74);
  static Color turquazS3 = const Color(0xff194D68);

  static Color blueS1 = const Color(0xff3d7cbe);
  static Color blueS2 = const Color(0xff003e7d);
  static Color blueS3 = const Color(0xff062f6a);

  static Color purpleS1 = const Color(0xff592d86);
  static Color purpleS2 = const Color(0xff3b185f);
  static Color purpleS3 = const Color(0xff2a0944);

  static Color redS1 = const Color(0xffff3535);
  static Color redS2 = const Color(0xffFF0000);
  static Color redS3 = const Color(0xffbf0016);

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
