// ignore_for_file: must_be_immutable, dead_code
import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_campagne_widget.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_category_widget.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_discount_widget.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_list_widget.dart';
import 'package:sepet_demo/View/Widget/Flows/flow_personal_widget.dart';

class FlowWidget extends StatelessWidget {
  FlowEntity data;
  FlowWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (data.type) {
      // case FlowType.announcement:
      //   return FlowAnnouncementWidget(
      //     data: data,
      //   );
      case FlowType.personal:
        return const SizedBox();
        return FlowPersonalWidget(data: data);
      case FlowType.campagne:
        return const SizedBox();
        return FlowCampagneWidget(data: data);
      case FlowType.discount:
        return const SizedBox();
        return FlowDiscountWidget(data: data);
      case FlowType.category:
        return const SizedBox();
        return FlowCategoryWidget(data: data);
      case FlowType.list:
        return FlowListWidget(data: data);
      default:
        return const SizedBox();
    }
  }
}
