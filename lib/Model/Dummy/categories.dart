import 'dart:convert';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/category.dart';

List<Category> categoryList = [];

Future<void> fetchCategories() async {
  try {
    var jsonText = await rootBundle.loadString('assets/data/categories.json');
    var data = await jsonDecode(jsonText);
    for (var item in data) {
      var catItem = Category.fromJson(item);
      catItem.icon = getIcon(catItem.categoryId, catItem.id);
      catItem.color = getCategoryColor(catItem.categoryId);
      categoryList.add(catItem);
    }
  } on Exception catch (e) {
    debugPrint('categories fetching error: $e');
  }
}
