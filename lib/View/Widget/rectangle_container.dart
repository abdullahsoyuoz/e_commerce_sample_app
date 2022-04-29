import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

class RectangleContainer extends StatelessWidget {
  final Widget child;
  const RectangleContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: context.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background.withOpacity(.5),
        borderRadius: appRadius(context),
        border: Border.all(width: 1, color: Colors.black)
        // boxShadow: appShadow(context),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      alignment: Alignment.centerRight,
      child: FittedBox(
        alignment: Alignment.centerRight,
        child: child,
      ),
    );
  }
}
