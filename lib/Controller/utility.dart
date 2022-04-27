import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension GetSize on BuildContext {
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  EdgeInsets get padding => mediaQuery.padding;
}

double discountedCalculate(double price, int? rate) {
  if (rate == null) {
    return price;
  } else {
    return (price - ((price * rate) / 100));
  }
}

double safeArea(
  BuildContext context, {
  double appBarHeight = 70,
  double extra = 0,
  double? paddingBottom,
  double? paddingTop,
}) =>
    (context.height -
        (paddingTop ?? context.padding.top) -
        (paddingBottom ?? context.padding.bottom) -
        appBarHeight -
        extra);

//

String getPrice(double price) {
  return ' ${price.toStringAsFixed(2)} ₺ ';
}
