import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/View/Style/colors.dart';

List<MyList> myListsTemplate = [
  MyList(
    title: 'myLiked',
    products: [],
    iconData: LineIcons.heart,
    color: AppColors.red.shade200,
    isConst: true,
  ),
  MyList(
    title: 'myTracking',
    products: [],
    iconData: LineIcons.bell,
    color: AppColors.orange.shade200,
    isConst: true,
  ),
  MyList(
    title: 'myLater',
    products: [],
    iconData: LineIcons.shoppingBag,
    color: AppColors.blue.shade200,
    isConst: true,
  ),
  MyList(
    title: 'Saatler',
    products: [],
    iconData: Icons.watch,
    color: AppColors.orange.shade300,
  ),
];

