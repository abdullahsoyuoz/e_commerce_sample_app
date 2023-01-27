import 'package:flutter/material.dart';
import 'package:sepet_demo/Controller/extensions.dart';

class StickyHeader extends SliverPersistentHeaderDelegate {
  String? title;
  StickyHeader({this.title});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: context.width,
        minWidth: context.width,
        maxHeight: 60,
        minHeight: 40,
      ),
      child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Text(title ?? '')),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
