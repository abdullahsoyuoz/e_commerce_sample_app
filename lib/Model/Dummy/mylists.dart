import 'dart:math';

import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
import 'package:sepet_demo/Model/mylist.dart';

List<MyList> myLists = [
  MyList(
    title: 'Beğendiklerim',
    iconData: LineIcons.heart,
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Fiyat takip',
    iconData: LineIcons.bell,
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Daha sonra',
    iconData: LineIcons.shoppingBag,
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Saatler',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Bilgisayar için ekipman',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Bi bak!!',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'kitapp',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'Fenerbahçe atkıları',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'sss',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'pp',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'aaaaa',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
  MyList(
    title: 'qqq',
    products: productList.take(Random().nextInt(8)+1).toList()
  ),
];
