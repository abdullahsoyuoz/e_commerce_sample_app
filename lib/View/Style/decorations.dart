import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sepet_demo/Controller/theme_helper.dart';

List<BoxShadow> appShadow(BuildContext context) =>
    Provider.of<ThemeChanger>(context, listen: false).isDark
        ? []
        : [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 0,
              color: Colors.black.withOpacity(
                0.25,
              ),
            ),
          ];

BorderRadius appRadius(BuildContext context) => BorderRadius.circular(10);
