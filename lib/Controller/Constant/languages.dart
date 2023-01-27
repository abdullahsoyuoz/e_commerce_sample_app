import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/Constant/constant.dart';

class AppLanguage {
  String? title;
  String? icon;
  Locale? locale;
  AppLanguage({
    this.title,
    this.icon,
    this.locale,
  });
}

List<AppLanguage> languageList = [
  AppLanguage(title: 'Türkçe', icon: flagTR, locale: const Locale('tr', 'TR')),
  AppLanguage(title: 'English', icon: flagEN, locale: const Locale('en', 'GB')),
  AppLanguage(title: 'Deutsch', icon: flagDE, locale: const Locale('de', 'DE')),
  AppLanguage(title: 'Français', icon: flagFR, locale: const Locale('fr', 'FR')),
  AppLanguage(title: 'Español', icon: flagES, locale: const Locale('es', 'ES')),
  AppLanguage(title: 'Português', icon: flagPT, locale: const Locale('pt', 'PT')),
];

