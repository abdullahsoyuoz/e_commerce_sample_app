import 'dart:math';

import 'package:faker_dart/faker_dart.dart';
import 'package:sepet_demo/Model/user.dart';

final User loginUser = User(
    name: Faker.instance.locale.name.femaleFirstName[Random()
            .nextInt(Faker.instance.locale.name.femaleFirstName.length)] +
        " " +
        Faker.instance.locale.name.femaleFirstName[Random()
            .nextInt(Faker.instance.locale.name.femaleFirstName.length)],
    photoUrl:
        "https://unsplash.com/photos/2crxTr4jCkc/download?ixid=MnwxMjA3fDB8MXxhbGx8fHx8fHx8fHwxNjQ5MzAxMjAy&force=true&w=640");
