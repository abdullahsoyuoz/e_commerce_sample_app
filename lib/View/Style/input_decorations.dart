import 'package:flutter/material.dart';
import 'package:sepet_demo/View/Style/colors.dart';

InputDecoration getAuthInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(.5),
      fontSize: 15,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
  );
}

InputDecoration getSearchInputDecoration(BuildContext context, String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: AppColors.grey.shade300,
      fontSize: 15,
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white.withOpacity(0), width: 1),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2),
    ),
  );
}
