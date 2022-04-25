import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/View/Style/colors.dart';

class FlowEntity {
  FlowEntity({
    this.title,
    this.description,
    this.imageUrl,
    this.icon,
    this.color,
    this.type,
    this.typeString,
    this.targetProduct,
    this.targetProducts,
    this.targetString,
  });

  late String? title;
  late String? description;
  late String? imageUrl;
  late IconData? icon;
  late MaterialColor? color;
  late FlowType? type;
  late String? typeString;
  late Product? targetProduct;
  late List<Product>? targetProducts;
  late String? targetString;
}

enum FlowType {
  personal,
  campagne,
  discount,
  list,
  category,
  // announcement,
}

IconData getFlowIcon(FlowType type) {
  switch (type) {
    case FlowType.personal:
      return FontAwesomeIcons.faceGrinStars;
    case FlowType.campagne:
      return FontAwesomeIcons.gift;
    case FlowType.discount:
      return FontAwesomeIcons.tag;
    case FlowType.list:
      return FontAwesomeIcons.bars;
    case FlowType.category:
      return FontAwesomeIcons.layerGroup;
    // case FlowType.announcement:
    //   return FontAwesomeIcons.bullhorn;
    default:
      return FontAwesomeIcons.question;
  }
}

MaterialColor getFlowColor(FlowType type) {
  switch (type) {
    case FlowType.personal:
      return AppColors.purple;
    case FlowType.campagne:
      return AppColors.red;
    case FlowType.discount:
      return AppColors.orange;
    case FlowType.list:
      return AppColors.blue;
    case FlowType.category:
      return AppColors.yellow;
    // case FlowType.announcement:
    //   return AppColors.turquaz;
    default:
      return AppColors.grey;
  }
}
