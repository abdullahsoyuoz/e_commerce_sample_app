import 'package:flutter/material.dart';

class Product {
  int? id;
  String? title;
  String? description;
  String? brand;
  String? model;
  String? category;
  double? rank;
  int? purchasesCount;
  int? commentCount;
  double? price;
  int? discountRate;
  DateTime? publishedDate;
  List<String>? photosUrl;
  String? shop;
  bool isLiked;
  bool isAddedBookmark;
  bool isAddedCart;
  bool isNew;

  List<Color>? colorOptions;
  Map<int, String>? sizeOptions;
  DateTime? modelDate;
  String? productWebUrl;

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
    this.productWebUrl,
  });

  factory Product.fromJson(Map<String, dynamic> item) {
    return Product(
      id: item["id"],
      title: item["title"],
      description: item["description"],
      brand: item["brand"],
      model: item["model"],
      category: item["category"],
      rank: item["rank"],
      purchasesCount: item["purchasesCount"],
      commentCount: item["commentCount"],
      price: item["price"],
      discountRate: item["discountRate"],
      publishedDate: DateTime.parse(item["publishedDate"]),
      photosUrl: List.castFrom(item["photosUrl"]),
      shop: item["shop"],
      modelDate: DateTime.parse(item["modelDate"]),
      productWebUrl: item["productWebUrl"]
    );
  }

  Map<String, dynamic> toMap() => {
        // "category_id": categoryId,
        // "id": id,
        // "title": title,
        // "imageUrl": imageUrl
      };

  @override
  String toString() {
    return '$title : $model';
  }
}
