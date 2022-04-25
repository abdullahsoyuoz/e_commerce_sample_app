import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  late bool _isDark;

  ThemeChanger(this._isDark);
  bool get isDark => _isDark;
  set isDark(bool value) {
    _isDark = value;
    notifyListeners();
  }

  void toggle() {
    _isDark = _isDark == true ? false : true;
    notifyListeners();
  }
}
