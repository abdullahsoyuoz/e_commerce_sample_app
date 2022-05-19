import 'package:flutter/material.dart';

InputDecoration getAuthInputDecoration(String hint, bool isDark) {
  return InputDecoration(
    hintText: hint,
    hintStyle: TextStyle(
      color: isDark ? Colors.white.withOpacity(.5) : Colors.black.withOpacity(.5),
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
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent, width: 1),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: Theme.of(context).iconTheme.color!, width: 2),
    ),
  );
}
