import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sepet_demo/View/Style/Theme/dark.dart';
import 'package:sepet_demo/View/Style/Theme/light.dart';

class ThemeChanger with ChangeNotifier {
  // late bool _isDark;
  late ThemeData _currentThemeData;

  ThemeChanger() {
    // _isDark =
    //     SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
    //         ? true
    //         : false;

    _currentThemeData =
        SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
            ? appDarkTheme
            : appLightTheme;
  }
  bool isDark() {
    if (_currentThemeData == appDarkTheme) {
      return true;
    } else {
      return false;
    }
  }

  // set setDark(bool value) {
  //   _isDark = value;
  //   notifyListeners();
  // }

  ThemeData get getTheme => _currentThemeData;

  void setTheme(ThemeData theme) {
    _currentThemeData = theme;
    notifyListeners();
  }

  // void toggle() {
  //   _isDark = _isDark == true ? false : true;
  //   notifyListeners();
  // }
}
