import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
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
      child: LineIcon(LineIcons.exclamationCircle),
    );
  }
  // ignore: unnecessary_null_comparison
  if (stackTrace == null) {
    return Center(
      child: LineIcon(LineIcons.exclamationCircle),
    );
  }
  return Center(
    child: LineIcon(LineIcons.exclamationCircle),
  );
}
