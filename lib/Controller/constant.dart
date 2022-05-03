// IMAGE ASSET
import 'dart:ui';

import 'package:sepet_demo/View/Style/colors.dart';

String logoSyz = 'assets/image/syz.png';

// URL ASSET

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
  5: "Takip edilenler",
};

Color getFilterIndicatorColor(int index) {
  switch (index) {
    case 0:
      return AppColors.black.shade300;
    case 1:
      return AppColors.purple.shade400;
    case 2:
      return AppColors.blue.shade400;
    case 3:
      return AppColors.orange.shade300;
    case 4:
      return AppColors.red.shade500;
    case 5:
      return AppColors.green.shade500;
    default:
      return AppColors.black;
  }
}
