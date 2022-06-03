import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/shop.dart';

class Product {
  int id;
  String title;
  String description;
  String brand;
  String model;
  String category;
  double rank;
  int purchasesCount;
  int commentCount;
  double price;
  int discountRate;
  DateTime publishedDate;
  List<String> photosUrl;
  Shop shop;
  bool isLiked;
  bool isAddedBookmark;
  bool isAddedCart;
  bool isNew;

  List<Color> colorOptions;
  Map<int, String> sizeOptions;
  DateTime modelDate;

  Product({
    this.id,
    this.title,
    this.description,
    this.brand,
    this.model,
    this.category,
    this.photosUrl,
    this.rank,
    this.purchasesCount,
    this.commentCount,
    this.price,
    this.discountRate,
    this.publishedDate,
    this.shop,
    this.isLiked = false,
    this.isAddedBookmark = false,
    this.isAddedCart = false,
    this.isNew = false,

    this.colorOptions,
    this.modelDate,
    this.sizeOptions,
  });

  @override
  String toString() {
    return '$title : $model';
  }
}
