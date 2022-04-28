// ignore_for_file: must_be_immutable

import 'package:faker_dart/faker_dart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sepet_demo/Controller/extensions.dart';

List<Widget> onBoardList = [
  OnboardWidget(
    icon: FontAwesomeIcons.palette,
    title: 'Modern',
    description:
        'Tamamen kullanıcı odaklı arayüz ile\nsizlerin alışverişinizi yaparken\nkeyif almanızı istiyoruz.',
  ),
  OnboardWidget(
    icon: FontAwesomeIcons.solidBookmark,
    title: 'Adaptif',
    description:
        'Kullanıcı odaklı servislerimiz ile\ntam da aradığınızı bulmada\nsizlere zaman kazandırmak istiyoruz.',
  ),
  OnboardWidget(
    icon: FontAwesomeIcons.icons,
    title: 'Eğlenceli',
    description:
        'Sevdiklerinize hediye yollamak mı?\nürün sipariş vermen kadar kolay.',
  ),
  OnboardWidget(
    icon: FontAwesomeIcons.lock,
    title: 'Güvenli',
    description: Faker.instance.lorem.sentence(wordCount: 7),
  ),
];

class OnboardWidget extends StatelessWidget {
  IconData icon;
  String title;
  String description;
  OnboardWidget(
      {Key? key,
      required this.icon,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.padding.top != 0 ? context.padding.top * 2 : 200,
        left: 20,
        right: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FaIcon(
            icon,
            color: Colors.white,
            size: context.width * 0.5,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 60, minHeight: 60),
                child: FittedBox(
                  alignment: Alignment.center,
                  fit: BoxFit.fitHeight,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lexend(
                      color: Colors.white,
                      fontSize: 1,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: FittedBox(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.readexPro(
                    color: Colors.white,
                    fontSize: 100,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 5,
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
