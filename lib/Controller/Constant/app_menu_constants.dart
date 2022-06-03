import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';

class AppMenu {
  int index;
  String title;
  IconData icon;
  IconData secondaryIcon;
  AppMenu({
    this.index,
    this.title,
    this.icon,
    this.secondaryIcon,
  });
}

List<AppMenu> settingsMenuItems = [
  AppMenu(
      index: 0,
      title: "theme",
      icon: LineIcons.sun,
      secondaryIcon: LineIcons.moon),
  AppMenu(index: 1, title: "notify", icon: LineIcons.bell),
  AppMenu(index: 2, title: "editProfile", icon: LineIcons.user),
];

void settingsCallbackHelper(BuildContext context, int index) {
  switch (index) {
    case 0:
      Provider.of<ThemeChanger>(context, listen: false).toggle();
      break;
    default:
  }
}

List<AppMenu> supportMenuItems = [
  AppMenu(index: 3, title: "contactUs", icon: LineIcons.headset),
  AppMenu(index: 4, title: "orderHelp", icon: LineIcons.truckLoading),
  AppMenu(index: 5, title: "myReviews", icon: LineIcons.certificate),
  AppMenu(index: 6, title: "feedback", icon: LineIcons.grinningFace),
  AppMenu(index: 7, title: "protectPersonalData", icon: LineIcons.fileContract),
  AppMenu(index: 8, title: "aboutUs", icon: LineIcons.identificationBadge),
];
