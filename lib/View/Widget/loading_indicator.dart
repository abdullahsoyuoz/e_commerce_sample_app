import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sepet_demo/View/Style/colors.dart';

Widget loadingIndicator(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  return loadingProgress == null
      ? child
      : Center(
          child: CircularProgressIndicator(
            value: loadingProgress.cumulativeBytesLoaded.toDouble() /
                loadingProgress.expectedTotalBytes!.toDouble(),
            color: AppColors.blue,
          ),
        );
}

Widget errorIndicator(BuildContext context, Object object, StackTrace stackTrace) {
  return const FaIcon(FontAwesomeIcons.triangleExclamation);
}