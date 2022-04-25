import 'package:flutter/material.dart';
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
