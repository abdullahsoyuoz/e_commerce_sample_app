import 'package:flutter/material.dart';

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

InputDecoration getSearchInputDecoration(String hint) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: Colors.white.withOpacity(.25),
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
