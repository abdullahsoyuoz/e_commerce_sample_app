import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/extensions.dart';

List<Widget> onBoardList = [
  const OnboardWidget(
    icon: LineIcons.palette,
    title: 'Modern?',
    description:
        'Sizler alışverişinizi yaparken\naynı zamanda keyif almanızı istiyoruz.',
  ),
  const OnboardWidget(
    icon: LineIcons.bookmark,
    title: 'Adaptif?',
    description:
        'Servislerimizle, tam da aradığınızı bulmada\nsizlere zaman kazandırmak istiyoruz.',
  ),
  const OnboardWidget(
    icon: LineIcons.gifts,
    title: 'Eğlenceli?',
    description:
        'Sevdiklerinize tek tıkla hediye yollamak mı?\nPeki kombin yaparken kararsız kaldığında\nsana kombinler önerelim?\n\nVe çok daha fazlası...',
  ),
  const OnboardWidget(
    icon: LineIcons.alternateShield,
    title: 'Güvenli?',
    description: 'Merak etmeyin.\nYalnızca eğlenmenizi değil\naynı zamanda güvende kalmanızı istiyoruz.',
  ),
];

class OnboardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const OnboardWidget(
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
        left: 30,
        right: 30,
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
                constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
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
              padding: const EdgeInsets.only(top: 50.0),
              child: FittedBox(
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.readexPro(
                    color: Colors.white,
                    fontSize: 70,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 5,
                    height: 1.4,
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
