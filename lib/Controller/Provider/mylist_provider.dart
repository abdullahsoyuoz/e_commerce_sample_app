import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/Dummy/mylists.dart';
import 'package:sepet_demo/Model/mylist.dart';
import 'package:sepet_demo/Model/product.dart';

class MyListsProvider with ChangeNotifier {
   List<MyList> myList;
  List<Product> orders = [];

  MyListsProvider() {
    myList = myListsTemplate;
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

  // ----------- LIKE

  Future<void> addLike(Product data) async {
    if (myList[0].products != null) {
      myList[0].products.add(data);
    }
    notifyListeners();
  }

  Future<void> removeLike(Product data) async {
    myList[0].products.remove(data);
    notifyListeners();
  }

  bool constainsLike(Product data) {
    if (myList[0].products.contains(data)) {
      return true;
    }
    return false;
  }

  // ------------- OTHER

  Future<void> addItem(Product data, int listIndex) async {
    if (myList[listIndex].products != null) {
      myList[listIndex].products.add(data);
    }
    notifyListeners();
  }

  Future<void> removeItem(Product data, int listIndex) async {
    myList[listIndex].products.remove(data);
    notifyListeners();
  }

  bool containsItem(Product data) {
    for (var item in myList) {
      if (item.products.contains(data)) {
        return true;
      }
    }
    return false;
  }

  // ---------- ORDER

  Future<void> addOrder(Product data) async {
    if (!containsOrder(data)) {
      orders.add(data);
      notifyListeners();
    }
  }

  Future<void> removeOrder(Product data) async {
    if (containsOrder(data)) {
      orders.removeAt(0);
      notifyListeners();
    }
  }

  bool containsOrder(Product data) {
    return orders.contains(data);
  }
}

final MyListsProvider myListsProvider = MyListsProvider();
