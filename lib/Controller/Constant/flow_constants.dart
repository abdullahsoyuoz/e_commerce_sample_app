import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

Map<int, String> flowFilter = {
  0: "Tümü",
  1: "Sana özel",
  2: "Listeler",
  3: "İndirimler",
  4: "Kampanyalar",
  5: "Takip'lerin",
};

Color getFilterIndicatorColor(int index) {
  switch (index) {
    case 0:
      return AppColors.turquaz;
    case 1:
      return AppColors.purple.shade400;
    case 2:
      return AppColors.blue.shade400;
    case 3:
      return AppColors.orange.shade400;
    case 4:
      return AppColors.red.shade400;
    case 5:
      return AppColors.green.shade400;
    default:
      return AppColors.black;
  }
}