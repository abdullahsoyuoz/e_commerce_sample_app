import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class Category {
  Category({
     this.categoryId,
     this.id,
     this.title,
    this.description,
    this.icon,
    this.color,
    this.subCategory,
    this.imageUrl,
  });

   int? categoryId; // nullable
   int? id;
   String? title;
   String? description;
 IconData? icon;
   MaterialColor? color;
 List<Category>? subCategory;
   String? imageUrl;

  factory Category.fromJson(Map<String, dynamic> item) {
    return Category(
      id: item["id"],
      categoryId: item["category_id"],
      title: item["title"],
      imageUrl: item["imageUrl"]
    );
  }

  Map<String, dynamic> toMap() => {
        "category_id": categoryId,
        "id": id,
        "title": title,
        "imageUrl": imageUrl
      };

  @override
  String toString() {
    return title!;
  }
}

IconData getIcon(int? category, int? index) {
  if (category == 0 && index == 0) return FontAwesomeIcons.tv;
  if (category == 0 && index == 1) return FontAwesomeIcons.gamepad;
  if (category == 0 && index == 2) return FontAwesomeIcons.clapperboard;
  if (category == 0 && index == 3) return FontAwesomeIcons.palette;

  if (category == 1 && index == 0) return FontAwesomeIcons.heartPulse;
  if (category == 1 && index == 1) return FontAwesomeIcons.solidHeart;
  if (category == 1 && index == 2) return FontAwesomeIcons.fireFlameCurved;
  if (category == 1 && index == 3) return FontAwesomeIcons.gem;

  if (category == 2 && index == 0) return FontAwesomeIcons.couch;
  if (category == 2 && index == 1) return FontAwesomeIcons.jarWheat;
  if (category == 2 && index == 2) return FontAwesomeIcons.radio;
  if (category == 2 && index == 3) return FontAwesomeIcons.broom;

  if (category == 3 && index == 0) return FontAwesomeIcons.carSide;
  if (category == 3 && index == 1) return FontAwesomeIcons.trowel;
  if (category == 3 && index == 2) return FontAwesomeIcons.screwdriverWrench;
  if (category == 3 && index == 3) return FontAwesomeIcons.penRuler;

  if (category == 4 && index == 0) return FontAwesomeIcons.cartShopping;
  if (category == 4 && index == 1) return FontAwesomeIcons.cow;
  if (category == 4 && index == 2) return FontAwesomeIcons.plantWilt;
  if (category == 4 && index == 3) return FontAwesomeIcons.cheese;
  return FontAwesomeIcons.question;
}

MaterialColor getCategoryColor(int? category) {
  if (category == 0) return AppColors.turquaz;
  if (category == 1) return AppColors.red;
  if (category == 2) return AppColors.green;
  if (category == 3) return AppColors.orange;
  // if (category == 4) return AppColors.green;
  return AppColors.grey;
}

String getCategoryTitle(int index) {
  if (index == 0) return 'EGLENCE';
  if (index == 1) return 'KISISEL';
  if (index == 2) return 'YASAM';
  if (index == 3) return 'ARAC & GEREC';
  if (index == 4) return 'GIDA';
  return '';
}

String getEnglishTitle(int? category, int? index) {
  if (category == 0 && index == 0) return 'Technology';
  if (category == 0 && index == 1) return 'Gaming';
  if (category == 0 && index == 2) return 'Movie';
  if (category == 0 && index == 3) return 'Art';

  if (category == 1 && index == 0) return 'Healt';
  if (category == 1 && index == 1) return 'Family';
  if (category == 1 && index == 2) return 'Sport';
  if (category == 1 && index == 3) return 'Gem';

  if (category == 2 && index == 0) return 'Armchair';
  if (category == 2 && index == 1) return 'Decor';
  if (category == 2 && index == 2) return 'Antique';
  if (category == 2 && index == 3) return 'Mop';

  if (category == 3 && index == 0) return 'Automobile';
  if (category == 3 && index == 1) return 'Garden';
  if (category == 3 && index == 2) return 'Industry';
  if (category == 3 && index == 3) return 'Ruler';

  if (category == 4 && index == 0) return 'Vegetables';
  if (category == 4 && index == 1) return 'Cow';
  if (category == 4 && index == 2) return 'Plant';
  if (category == 4 && index == 3) return 'Cheese';
  return 'Product';
}
