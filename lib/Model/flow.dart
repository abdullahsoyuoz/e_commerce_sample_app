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

   String? title;
   String? description;
   String? imageUrl;
 IconData? icon;
   Color? color;
 FlowType? type;
   String? typeString;
   Product? targetProduct;
   List<Product?>? targetProducts;
   String? targetString;
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
      return AppColors.purple.shade300;
    case FlowType.campagne:
      return AppColors.red.shade300;
    case FlowType.discount:
      return AppColors.orange.shade300;
    case FlowType.list:
      return AppColors.blue.shade300;
    case FlowType.saved:
      return AppColors.yellow.shade300;
    // case FlowType.category:
    //   return AppColors.yellow.shade500;
    // case FlowType.announcement:
    //   return AppColors.turquaz;
    default:
      return AppColors.grey;
  }
}
