// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';
import 'package:sepet_demo/Controller/utility.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/View/Widget/loading_indicator.dart';

class FlowPersonalWidget extends StatelessWidget {
  FlowEntity data;
  FlowPersonalWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _dark = Provider.of<ThemeChanger>(context, listen: false).isDark;
    return SizedBox(
      width: context.width,
      child: Stack(
        fit: StackFit.expand,
        children: [
          _dark
              ? Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox.expand(
                      child: ColoredBox(color: data.color!.shade200)))
              : const SizedBox(),
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
                data.title!.toUpperCase(),
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    backgroundColor:
                        _dark ? Colors.white : data.color),
              ),
            ),
          )
        ],
      ),
    );
  }
}
