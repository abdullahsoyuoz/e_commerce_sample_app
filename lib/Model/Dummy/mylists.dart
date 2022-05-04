import 'dart:math';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/View/Style/colors.dart';

List<MyList> myListsCache = [
  MyList(
    title: 'Beğendiklerim',
    products: productList.take(Random().nextInt(1) + 1).toList(),
    iconData: LineIcons.heart,
    color: AppColors.red.shade400,
    isConst: true,
  ),
  MyList(
    title: 'Fiyat takip',
    products: [],
    iconData: LineIcons.bell,
    color: AppColors.turquaz.shade400,
    isConst: true,
  ),
  MyList(
    title: 'Daha sonra',
    products: [],
    iconData: LineIcons.shoppingBag,
    color: AppColors.blue.shade400,
    isConst: true,
  ),
  MyList(
    title: 'Saatler',
    products: [],
    iconData: Icons.watch,
    color: AppColors.orange.shade400,
  ),
];

