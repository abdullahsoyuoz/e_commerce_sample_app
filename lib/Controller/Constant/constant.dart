// ignore_for_file: constant_identifier_names

import 'dart:ui';

String logoSyz = 'assets/image/logo/syz.png';
String combinLight = 'assets/image/logo/combin_light.png';
String combinDark = 'assets/image/logo/combin_dark.png';

String flagTR = "assets/image/flags/tr.png";
String flagEN = "assets/image/flags/en.png";
String flagDE = "assets/image/flags/de.png";
String flagFR = "assets/image/flags/fr.png";
String flagES = "assets/image/flags/es.png";
String flagPT = "assets/image/flags/pt.png";

final supportedLanguages = [
  const Locale('en', 'US'),
  const Locale('tr', 'TR'),
];

class ConstantDuration {
  static int slowly = 1000;
  static int normal = 500;
  static int faster = 300;
}

enum Direction { UP, DOWN, LEFT, RIGHT }
