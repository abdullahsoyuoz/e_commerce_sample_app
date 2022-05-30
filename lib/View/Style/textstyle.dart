import 'package:flutter/material.dart';

TextStyle textfieldstyle(BuildContext context) => Theme.of(context).textTheme.bodyText2;

TextStyle getNoenStyle(BuildContext context, MaterialColor color) => TextStyle(
      color: Colors.white,
      fontFamily: 'Beon',
      shadows: [
        const Shadow(color: Colors.black, blurRadius: 3, offset: Offset.zero),
        Shadow(color: color.shade300, blurRadius: 5, offset: Offset.zero),
        Shadow(color: color.shade300, blurRadius: 10, offset: Offset.zero),
        Shadow(color: color.shade300, blurRadius: 30, offset: Offset.zero),
      ],
    );
