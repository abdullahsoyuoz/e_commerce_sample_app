// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Style/textstyle.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowAnnouncementWidget extends StatelessWidget {
  FlowEntity data;
  FlowAnnouncementWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: context.width,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              data.imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingIndicator(context, child, loadingProgress),
            ),
            Center(
                child: Text(
              data.title!,
              style: getBlackBackgroundStyle(context),
            ))
          ],
        ));
  }
}
