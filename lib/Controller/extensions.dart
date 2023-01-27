import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}

extension GetSize on BuildContext {
  double get width => mediaQuery.size.width;
  double get height => mediaQuery.size.height;
  EdgeInsets get padding => mediaQuery.padding;
}

extension AddWhitespace on String {
  String get addWhitespace => ' ${this} ';
}

extension TwoDigit on double {
  String get twoDigitForMoney => ' ${toStringAsFixed(2)} ${NumberFormat.simpleCurrency(locale: 'TR').currencySymbol} ';
}

extension OneDigit on double {
  String get oneDigitForRankString => '${toString()[0]}.${toString()[2]}';
}

extension AddParanthesis on String {
  String get addParanthesis => '(${toString()})';
}

extension RankRoundToHalf on double {
  double get rankRoundToHalf => this == 5.0
      ? 5.0
      : this % floor() < 0.5
          ? floorToDouble()
          : floorToDouble() + 0.5;
}

// OFFSIDE

double? discountedCalculate(double? price, int? rate) {
  if (rate == null) {
    return price;
  } else {
    return (price! - ((price * rate) / 100));
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


