import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/Dummy/mylists.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/Model/product.dart';

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
