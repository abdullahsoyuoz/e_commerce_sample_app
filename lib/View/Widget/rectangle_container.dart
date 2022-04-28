import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

class RectangleContainer extends StatelessWidget {
  final Widget child;
  const RectangleContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: context.width * 0.6,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: appRadius(context),
        boxShadow: appShadow(context),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
