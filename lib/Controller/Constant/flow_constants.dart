import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

Map<int, String> flowFilter = {
  0: "flowMixed",
  1: "flowSpecial4You",
  2: "flowList",
  3: "flowDiscounts",
  4: "flowCampaigns",
  5: "flowFollows",
};

Color? getFilterIndicatorColor(int index, BuildContext context) {
  switch (index) {
    case 0:
      return Theme.of(context).iconTheme.color;
    case 1:
      return AppColors.purple.shade200;
    case 2:
      return AppColors.blue.shade200;
    case 3:
      return AppColors.orange.shade200;
    case 4:
      return AppColors.red.shade200;
    case 5:
      return AppColors.green.shade200;
    default:
      return AppColors.black;
  }
}