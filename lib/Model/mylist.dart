import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/product.dart';

class MyList {
  String? title;
  List<Product?>? products;
  IconData? iconData;
  Color? color;
  bool isConst;
  bool isVisible;
  MyList({
    this.title,
    this.products,
    this.iconData,
    this.color,
    this.isConst = false,
    this.isVisible = true,
  });
}
