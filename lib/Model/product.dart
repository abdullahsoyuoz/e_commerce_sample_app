import 'package:sepet_demo/Model/shop.dart';

class Product {
  late int? id;
  late String? title;
  late String? description;
  late String? brand;
  late String? model;
  late String? category;
  late double? rank;
  late int? purchasesCount;
  late int? commentCount;
  late double? price;
  late int? discountRate;
  late DateTime? publishedDate;
  late List<String>? photosUrl;
  late Shop? shop;
  late bool isLiked;
  late bool isAddedBookmark;
  late bool isAddedCart;
  late bool isNew;

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
  });

  @override
  String toString() {
    return '$title : $model';
  }
}
