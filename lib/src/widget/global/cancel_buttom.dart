import 'package:flutter/material.dart';

class CancelButtonConfig {
  /// The text displayed on the button. Defaults to "انتخاب" (Persian for "Select").
  final String text;

  /// The minimum width of the button. Defaults to null.
  final double? minWidth;

  final double height;

  /// The color of the button's background. Defaults to Colors.blue.
  final Color color;

  /// The border style of the button. Defaults to const StadiumBorder().
  final ShapeBorder shape;

  /// The text style for the button's text.
  final TextStyle? style;

  CancelButtonConfig({
    this.height = 40,
    this.minWidth,
    this.shape = const StadiumBorder(),
    this.style = const TextStyle(color: Colors.white),
    this.color = Colors.red,
    this.text = "لغو",
  });
}