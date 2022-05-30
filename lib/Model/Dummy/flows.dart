import 'dart:math';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:sepet_demo/Model/Dummy/categories.dart';
import 'package:sepet_demo/Model/Dummy/products.dart';
import 'package:sepet_demo/Model/category.dart';
import 'package:sepet_demo/Model/flow.dart';
import 'package:sepet_demo/Model/category.dart' as cat;

List<FlowEntity> flowList = [];

Future<void> generateFlow() async {
  Faker faker = Faker.instance;
  for (var i = 0; i < 70; i++) {
    FlowType type = FlowType.values.elementAt(Random().nextInt(FlowType.values.length - 1));
    // FlowType type = FlowType.values.elementAt(3);
    var assist = categoryList[Random().nextInt(categoryList.length)];
    var targetProduct = type == FlowType.list ? productList[Random().nextInt(productList.length - 1) + 1] : Random().nextBool() ? productList[Random().nextInt(productList.length)] : null;
    try {
      final item = FlowEntity(
          type: type,
          title: getFlowTitle(type, assist.title)[Random().nextInt(3)],
          color: getFlowColor(type),
          description: faker.lorem.sentence(wordCount: 7),
          imageUrl: getFlowImageUrl(type, assist),
          typeString: getTypeString(type),
          targetProduct: targetProduct,
          targetProducts: productList.take(Random().nextInt(10) + 5).toList(),
          targetString: getEnglishTitle(assist.categoryId, assist.id));

      flowList.add(item);
    } on Exception catch (e) {
      debugPrint('flow generate error: ' + e.toString());
    }
  }
}

String getFlowImageUrl(FlowType type, cat.Category assist) {
  Faker faker = Faker.instance;
  switch (type) {
    case FlowType.personal:
      return faker.image.unsplash.people(keyword: getEnglishTitle(assist.categoryId, assist.id));
    case FlowType.campagne:
      return faker.image.unsplash.image(keyword: getEnglishTitle(assist.categoryId, assist.id));
    case FlowType.discount:
      return faker.image.unsplash.image(keyword: getEnglishTitle(assist.categoryId, assist.id));
    case FlowType.list:
      return faker.image.unsplash.image(keyword: getEnglishTitle(assist.categoryId, assist.id));
    // case FlowType.category:
    //   return faker.image.unsplash.image(keyword: getEnglishTitle(assist.categoryId, assist.id));
    // case FlowType.announcement:
    //   return faker.image.unsplash.image(keyword: 'bullhorn');
    default:
      return faker.image.unsplash.people(keyword: 'not found');
  }
}

String getTypeString(FlowType type) {
  switch (type) {
    case FlowType.personal:
      return 'flowSpecial4You';
    case FlowType.campagne:
      return 'flowCampaigns';
    case FlowType.discount:
      return 'flowDiscounts';
    case FlowType.list:
      return 'flowList';
    // case FlowType.category:
    //   return 'kategorik içerik';
    // case FlowType.announcement:
    //   return 'duyuru';
    default:
      return 'notFound';
  }
}

List<String> getFlowTitle(FlowType type, String assistText) {
  List<String> time = ['aylık', 'haftalık', 'günlük'];
  List<String> summer = ['yaz', 'kış', 'bahar'];
  List<String> tamamlayici = ['sevilen', 'favori', 'popüler', 'ekonomik'];
  int random = Random().nextInt(3) + 2;

  if (type == FlowType.campagne) {
    return [
      '$assistText ürünlerinde $random al ${random - 1} öde',
      'Sevgililer gününe özel $assistText ürünlerinde büyük kampanyalar',
      '$assistText ürünlerinde babalar gününe özel fırsatlar'
    ];
  }
  if (type == FlowType.personal) {
    return [
      'son gezdiğin ürünlere benzer',
      'son siparişine kombinler',
      'ilgilendiklerinden indirime düşenler',
    ];
  }
  if (type == FlowType.discount) {
    return [
      '$assistText ürünlerinde %${(Random().nextInt(8) + 1) * 10} varan indirimler',
      '$assistText markasında büyük indirimler',
      'doğum gününe özel %${Random().nextInt(8) + 1 * 10} varan indirimler'
    ];
  }
  if (type == FlowType.list) {
    return [
      'X influencer\'ın listesi',
      '${time[Random().nextInt(time.length)]} en ${tamamlayici[Random().nextInt(tamamlayici.length)]}ler',
      'bu ${summer[Random().nextInt(summer.length)]}ın en ${tamamlayici[Random().nextInt(tamamlayici.length)]}leri',
    ];
  }
  // if (type == FlowType.category) {
  //   return [
  //     '$assistText ürünlerinde bir göz at',
  //     'son baktıkların $assistText kategorisine ait',
  //     'ilgini çekebilecek $assistText ürünleri',
  //   ];
  // }
  // if (type == FlowType.announcement) {
  //   return [
  //     'yeni güncelleme ile değişimler',
  //     'yeni güncelleme ile değişimler',
  //     'yeni güncelleme ile değişimler',
  //   ];
  // }
  return ['', '', ''];
}
