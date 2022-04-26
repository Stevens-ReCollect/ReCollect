import 'package:flutter/material.dart';

class TextSizeConstants {
  const TextSizeConstants();
  static const double h1 = 64;
  static const double h2 = 30;
  static const double formField = 18;
  static const double buttonText = 24;
  static const double memoryTitle = 30;
  static const double tag = 18;
  static const double bodyText = 24;
  static const double dropDownText = 18;
  static const double hint = 12;
  static const double largeTextButtons = 20;

  static getadaptiveTextSize(BuildContext context, double value) {
    return (value / 900) * MediaQuery.of(context).size.height;
  }
}
