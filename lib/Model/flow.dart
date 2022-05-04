import 'package:flutter/material.dart';
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
  late Color? color;
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
  saved,
  // category,
  // announcement,
}


Color getFlowColor(FlowType type) {
  switch (type) {
    case FlowType.personal:
      return AppColors.purple.shade400;
    case FlowType.campagne:
      return AppColors.red.shade500;
    case FlowType.discount:
      return AppColors.orange.shade300;
    case FlowType.list:
      return AppColors.blue.shade400;
    case FlowType.saved:
      return AppColors.yellow.shade500;
    // case FlowType.category:
    //   return AppColors.yellow.shade500;
    // case FlowType.announcement:
    //   return AppColors.turquaz;
    default:
      return AppColors.grey;
  }
}
