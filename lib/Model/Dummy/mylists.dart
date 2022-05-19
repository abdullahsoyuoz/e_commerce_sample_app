import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/View/Style/colors.dart';

List<MyList> myListsTemplate = [
  MyList(
    title: 'Beğendiklerim',
    products: [],
    iconData: LineIcons.heart,
    color: AppColors.red.shade300,
    isConst: true,
  ),
  MyList(
    title: 'Fiyat takip',
    products: [],
    iconData: LineIcons.bell,
    color: AppColors.turquaz.shade300,
    isConst: true,
  ),
  MyList(
    title: 'Daha sonra',
    products: [],
    iconData: LineIcons.shoppingBag,
    color: AppColors.blue.shade300,
    isConst: true,
  ),
  MyList(
    title: 'Saatler',
    products: [],
    iconData: Icons.watch,
    color: AppColors.orange.shade300,
  ),
];

