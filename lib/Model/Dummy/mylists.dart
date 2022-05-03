import 'dart:math';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/Model/product.dart';
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

class MyListsProvider with ChangeNotifier {
  late List<MyList> myList;

  MyListsProvider() {
    myList = myListsCache;
  }

  List<MyList> getList() {
    return myList;
  }

  Future<void> addList(MyList data) async {
    myList.add(data);
    notifyListeners();
  }

  Future<void> removeList(index) async {
    myList.removeAt(index);
    notifyListeners();
  }

  Future<void> addItem(Product data, int listIndex) async {
    if (myList[listIndex].products != null) {
      myList[listIndex].products!.add(data);
    }
    notifyListeners();
  }

  Future<void> removeItem(Product data, int listIndex) async {
    myList[listIndex].products!.remove(data);
    notifyListeners();
  }
}

final MyListsProvider myListsProvider = MyListsProvider();
