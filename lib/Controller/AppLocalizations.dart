// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocalizations {
  Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = Locale(locale.languageCode == "tr" ? "tr" : "en",locale.languageCode == "tr" ? "tr" : "en");
    String lang;
    if (prefs.containsKey("lang")) {
      lang = prefs.getString("lang");
      locale = Locale(prefs.getString("lang"), prefs.getString("lang"));
    }
    var currentLangCode = lang ?? locale.languageCode;
    var otherLangCode = currentLangCode == "tr" ? "en" : "tr";

    String jsonString = await rootBundle.loadString('i18n/$currentLangCode.json');
    String jsonStringOther = await rootBundle.loadString('i18n/$otherLangCode.json');

    Map<String, dynamic> jsonMap = json.decode(jsonString);
    Map<String, dynamic> jsonMapOther = json.decode(jsonStringOther);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    for (var key in jsonMapOther.keys) {
      if (!_localizedStrings.containsKey(key)) {
        _localizedStrings[key] = jsonMapOther[key];
      }
    }

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("lang")) {
      locale = Locale(prefs.getString("lang"), prefs.getString("lang"));
    }
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

String languageConverter(BuildContext context, String nameParam){
  return AppLocalizations.of(context).translate(nameParam);
}