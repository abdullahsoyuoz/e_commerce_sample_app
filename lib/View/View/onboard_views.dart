import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sepet_demo/Controller/AppLocalizations.dart';
import 'package:sepet_demo/Controller/extensions.dart';

List<Widget> onBoardList = [
  const OnboardWidget(
    icon: LineIcons.palette,
    title: 'onboard1Title',
    description: 'onboard1Description',
  ),
  const OnboardWidget(
    icon: LineIcons.bookmark,
    title: 'onboard2Title',
    description: 'onboard2Description',
  ),
  const OnboardWidget(
    icon: LineIcons.gifts,
    title: 'onboard3Title',
    description: 'onboard3Description',
  ),
  const OnboardWidget(
    icon: LineIcons.alternateShield,
    title: 'onboard4Title',
    description: 'onboard4Description',
  ),
];

class OnboardWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const OnboardWidget({Key key, this.icon, this.title, this.description})
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
                constraints: const BoxConstraints(maxHeight: 40, minHeight: 40),
                child: FittedBox(
                  alignment: Alignment.center,
                  child: Text(
                    languageConverter(context, title).toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 1,
                      fontWeight: FontWeight.bold,
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
                  languageConverter(context, description).toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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
