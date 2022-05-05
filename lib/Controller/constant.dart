// IMAGE ASSET
import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

String logoSyz = 'assets/image/syz.png';

// LOTTIE ASSET
String lottieSpinnerPurple = 'assets/lottie/spinner_purple.json';
String lottieSpinnerWhite = 'assets/lottie/spinner_white.json';
String lottieSpinnerBlack = 'assets/lottie/spinner_black.json';
String lottieSpinnerFilter = 'assets/lottie/spinner_filter.json';

List<String> searchHintList = [
  'Ürünlerde ara',
  'Kategorilerde ara',
  'Kampanyalarde ara',
  'Markalarda ara',
  'Listelerde ara',
];

Map<int, String> navigationMenu = {
  0: "Kategoriler",
  1: "Ayarlar",
  2: "Yardım",
};

Map<int, String> flowFilter = {
  0: "Tümü",
  1: "Sana özel",
  2: "Listeler",
  3: "İndirimler",
  4: "Kampanyalar",
  5: "Takip'lerin",
};

Color getFilterIndicatorColor(BuildContext context, int index) {
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
