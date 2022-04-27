import 'dart:math';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:sepet_demo/Model/product.dart';
import 'package:sepet_demo/Model/shop.dart';

List<Product> productList = [];
List<Shop> shopList = [];
List<String> brandList = [];

Future<void> generateProduct() async {
  try {
    final faker = Faker.instance;
    for (var i = 0; i < 50; i++) {
      final productCategory = faker.locale.commerce.productName.product![
          Random()
              .nextInt(faker.locale.commerce.productName.product!.length - 1)];
      final data = Product(
        id: i,
        brand: brandList[Random().nextInt(brandList.length)],
        category: productCategory,
        title: faker.locale.commerce.productName.adjective![Random()
                .nextInt(faker.locale.commerce.productName.adjective!.length)] +
            ' ' +
            productCategory,
        photosUrl: picturegenerator(productCategory),
        description: faker.locale.commerce.productDescription![Random()
            .nextInt(faker.locale.commerce.productDescription!.length - 1)],
        model: faker.locale.commerce.productName.product![Random()
            .nextInt(faker.locale.commerce.productName.product!.length - 1)],
        price: Random().nextDouble() * Random().nextInt(1000),
        discountRate: Random().nextBool() ? Random().nextInt(8) + 1 * 10 : null,
        publishedDate: faker.date.past(DateTime.now(), rangeInYears: 15),
        rank: Random().nextDouble() + 4,
        rankCount: 1000 + Random().nextInt(3000),
        commentCount: 3000 + Random().nextInt(7000),
        shop: shopList[Random().nextInt(shopList.length - 1)],
      );
      // print('product:: ' + data.toString());
      productList.add(data);
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
        name: faker.lorem.word() + ' ' + faker.company.companySuffix(),
        city: faker.address.city(),
        country: faker.address.country(),
        contactNumber: faker.phoneNumber.phoneNumber(),
        email: faker.lorem.word() +
            '@' +
            faker.locale.internet.freeEmail![
                Random().nextInt(faker.locale.internet.freeEmail!.length)],
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
        faker.lorem.word() +
            ' ' +
            faker.locale.commerce.department![
                Random().nextInt(faker.locale.commerce.department!.length - 1)],
      );
    }
  } on Exception catch (e) {
    debugPrint('brand:: ' + e.toString());
  }
}

List<String> picturegenerator(String title) {
  return [
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
    Faker.instance.image.unsplash.image(keyword: title, w: 800, h: 600),
  ];
}
