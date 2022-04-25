import 'package:flutter/material.dart';

TextStyle textfieldstyle = const TextStyle(
  color: Colors.white,
  fontSize: 15,
);

TextStyle getNoenStyle(BuildContext context, MaterialColor color) => TextStyle(
      color: Colors.white,
      fontFamily: 'Beon',
      shadows: [
        const Shadow(color: Colors.black, blurRadius: 3, offset: Offset.zero),
        Shadow(color: color.shade300, blurRadius: 5, offset: Offset.zero),
        Shadow(color: color.shade400, blurRadius: 10, offset: Offset.zero),
        Shadow(color: color.shade500, blurRadius: 30, offset: Offset.zero),
      ],
    );
TextStyle getBlackBackgroundStyle(BuildContext context, {Color? backgroundColor}) => TextStyle(
      color: Theme.of(context).textTheme.titleMedium!.color,
      fontSize: 14,
      backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.background,
      height: 1.5,
      letterSpacing: 1,
    );
