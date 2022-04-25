// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowPersonalWidget extends StatelessWidget {
  FlowEntity data;
  FlowPersonalWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Transform.scale(
              scale: 1,
              alignment: Alignment.center,
              child: SizedBox.expand(
                  child: ColoredBox(color: data.color!.withOpacity(1))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.network(
              data.imageUrl!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) =>
                  loadingIndicator(context, child, loadingProgress),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                  data.title!
                      .replaceAll('_', ' ')
                      .replaceAll('-', ' ')
                      .toUpperCase(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(decoration: TextDecoration.lineThrough)),
            ),
          )
        ],
      ),
    );
  }
}
