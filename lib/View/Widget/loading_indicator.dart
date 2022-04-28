import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sepet_demo/Controller/constant.dart';
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

Widget errorIndicator(
    BuildContext context, Object object, StackTrace stackTrace) {
  if (stackTrace == StackTrace.empty) {
    return Center(
      child: Lottie.asset(lottiePathError, height: 100),
    );
  }
  // ignore: unnecessary_null_comparison
  if (stackTrace == null) {
    return Center(
      child: Lottie.asset(lottiePathError, height: 100),
    );
  }
  return Center(
    child: Lottie.asset(lottiePathError, height: 100),
  );
}
