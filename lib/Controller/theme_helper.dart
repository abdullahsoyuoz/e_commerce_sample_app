import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeChanger with ChangeNotifier {
  late bool _isDark;

  ThemeChanger() {
    _isDark =
        SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
            ? true
            : false;
  }
  bool isDark() => _isDark;

  void setTheme(bool dark) {
    _isDark = dark;
    notifyListeners();
  }

  void toggle() {
    _isDark = _isDark == true ? false : true;
    notifyListeners();
  }
}
