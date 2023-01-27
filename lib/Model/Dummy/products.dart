import 'dart:convert';
import 'dart:math';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/Model/shop.dart';
import 'package:sepet_demo/View/Style/colors.dart';
import 'package:flutter/services.dart' show rootBundle;

Product? productItem;
List<Product?> productList = [];
List<Shop> shopList = [];
List<String> brandList = [];

Future<void> fetchProduct() async {
  try {
    var jsonText = await rootBundle.loadString('assets/data/fakeProduct.json');
    var data = await jsonDecode(jsonText);
    for (var item in data) {
      productItem = Product.fromJson(item);
      productList.add(productItem);
      // categoryList.add(catItem);
    }
  } on Exception catch (e) {
    debugPrint('product fetching error: $e');
  }
}

Future<void> generateProduct() async {
  try {
    // ignore: unused_local_variable
    final faker = Faker.instance;
    for (var i = 0; i < 50; i++) {

      // final productCategory = faker.locale.commerce.productName.product[Random()
      //     .nextInt(faker.locale.commerce.productName.product.length - 1)];
      // var count = 1000 + Random().nextInt(3000000);
      // colorOptionsConst.shuffle();
      // final data = Product(
      //   id: i,
      //   brand: brandList[Random().nextInt(brandList.length)],
      //   category: productCategory,
      //   title: faker.locale.commerce.productName.adjective[Random()
      //           .nextInt(faker.locale.commerce.productName.adjective.length)] +
      //       ' ' +
      //       productCategory,
      //   photosUrl: picturegenerator(productCategory),
      //   description: faker.locale.commerce.productDescription[Random()
      //       .nextInt(faker.locale.commerce.productDescription.length - 1)],
      //   model: faker.locale.commerce.productName.product[Random()
      //       .nextInt(faker.locale.commerce.productName.product.length - 1)],
      //   price: Random().nextDouble() * Random().nextInt(1000),
      //   discountRate: Random().nextBool() ? Random().nextInt(8) + 1 * 10 : null,
      //   publishedDate: faker.date.past(DateTime.now(), rangeInYears: 15),
      //   rank: Random().nextDouble() + (Random().nextInt(3) + 1),
      //   purchasesCount: count,
      //   commentCount: count ~/ (Random().nextInt(10000) + 1),
      //   // shop: shopList[Random().nextInt(shopList.length - 1)],
      //   isNew: Random().nextBool() ? Random().nextBool() : false,

      //   // colorOptions: colorOptionsConst.take(Random().nextInt(4) + 1),
      //   // modelDate: faker.date.past(DateTime.now(), rangeInYears: 15),
      //   // sizeOptions: bodySize
      // );
      // print('product:: ' + data.toString());
      // productList.add(data);
    }
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> generateShop() async {
  try {
    final faker = Faker.instance;
    for (var index = 0; index < 50; index++) {
      final data = Shop(
        id: index,
        name: '${faker.lorem.word()} ${faker.company.companySuffix()}',
        city: faker.address.city(),
        country: faker.address.country(),
        contactNumber: faker.phoneNumber.phoneNumber(),
        email: '${faker.lorem.word()}@${faker.locale.internet.freeEmail![
                Random().nextInt(faker.locale.internet.freeEmail!.length)]}',
        logoUrl: faker.image.unsplash.objects(keyword: 'logo'),
        websiteUrl: faker.internet.url(),
      );
      shopList.add(data);
    }
    generateBrand();
  } on Exception catch (e) {
    debugPrint(e.toString());
  }
}

Future<void> generateBrand() async {
  try {
    final faker = Faker.instance;
    for (var i = 0; i < 20; i++) {
      brandList.add(
        '${faker.lorem.word()} ${faker.locale.commerce.department![
                Random().nextInt(faker.locale.commerce.department!.length - 1)]}',
      );
    }
  } on Exception catch (e) {
    debugPrint('brand:: $e');
  }
}

List<String> picturegenerator(String title) {
  return [
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
  ];
}

Map<int, String> bodySize = {
  0: "XS",
  1: "S",
  2: "M",
  3: "L",
  4: "XL",
  5: "XXL",
  6: "XXXL"
};

List<Color> colorOptionsConst = [
  AppColors.red,
  AppColors.yellow,
  AppColors.green,
  AppColors.blue,
  AppColors.purple,
  AppColors.turquaz,
  AppColors.black.shade300,
  AppColors.grey.shade100,
];
