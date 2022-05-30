import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';
import 'package:sepet_demo/View/Style/decorations.dart';

class SearchFrame extends StatelessWidget {
  final Widget child;
  final double height;
  const SearchFrame({Key key, this.child, this.height = 50}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: context.width,
      decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor.withOpacity(0.5),
          borderRadius: appRadius(),
          border: Border.all(width: 2, color: Theme.of(context).iconTheme.color)
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
