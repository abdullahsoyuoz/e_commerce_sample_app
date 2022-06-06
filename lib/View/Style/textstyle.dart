import 'package:flutter/material.dart';

TextStyle getTextFieldStyle(BuildContext context) =>
    Theme.of(context).textTheme.bodyText2;

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

TextStyle getSpacingStyle() => const TextStyle(fontSize: 17, letterSpacing: 3);

TextStyle getAccentStyle() =>
    const TextStyle(fontSize: 21, fontWeight: FontWeight.w500);

TextStyle getAccentBoldStyle() => const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,
    );
