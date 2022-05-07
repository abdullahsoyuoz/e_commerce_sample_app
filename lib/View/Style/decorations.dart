import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';

List<BoxShadow> appShadow(BuildContext context) =>
    Provider.of<ThemeChanger>(context, listen: false).isDark()
        ? []
        : [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
              color: Colors.black.withOpacity(
                0.5,
              ),
            ),
          ];

BorderRadius appRadius() =>
    BorderRadius.circular(appPaddingForRadius() * 2);

double appPaddingForRadius() => 15;

double lineThickness() => 1;
