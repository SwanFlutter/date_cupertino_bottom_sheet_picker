import 'package:flutter/material.dart';

class TextFieldDecoration {
  final InputBorder? border;
  final Color borderColor;
  final double borderRadius;
  final Color cursorColor;
  final Color enabledBorderColor;
  final String? errorText;
  final Color errorColor;
  final bool? filled;
  final Color? fillColor;
  final bool isDense;
  final Color focusedBorderColor;
  final double height;
  final String hintText;
  final Color hintColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String? labelText;
  final Color labelColor;
  final String prefix;
  final TextStyle? prefixStyle;
  final TextStyle? style;
  final double widthBorder;
  final double widthEnabledBorder;
  final double widthFocusedBorder;

  // New properties
  final Widget? suffixIcon;
  final VoidCallback? suffixIconOnTap;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  // Container properties
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? containerMargin;
  final double? containerWidth;
  final double? containerHeight;
  final BoxDecoration? containerDecoration;
  final Gradient? gradient;
  final List<BoxShadow>? boxShadow;
  final Color? containerColor;

  TextFieldDecoration({
    this.border,
    this.borderColor = Colors.black,
    this.borderRadius = 12.0,
    this.cursorColor = Colors.black,
    this.enabledBorderColor = Colors.black,
    this.errorText,
    this.errorColor = Colors.red,
    this.filled = false,
    this.fillColor = Colors.white,
    this.isDense = true,
    this.focusedBorderColor = Colors.black,
    this.height = 15.0,
    this.hintText = '',
    this.hintColor = Colors.black,
    this.icon = Icons.calendar_month_rounded,
    this.iconColor = Colors.black,
    this.iconSize = 24.0,
    this.labelText,
    this.labelColor = Colors.black,
    this.prefix = '',
    this.prefixStyle = const TextStyle(fontSize: 20, color: Colors.black),
    this.style = const TextStyle(color: Colors.black),
    this.widthBorder = 1.0,
    this.widthEnabledBorder = 1.0,
    this.widthFocusedBorder = 1.0,

    // New properties
    this.suffixIcon,
    this.suffixIconOnTap,
    this.textDirection,
    this.textAlign = TextAlign.start,

    // Container properties
    this.containerPadding,
    this.containerMargin,
    this.containerWidth,
    this.containerHeight,
    this.containerDecoration,
    this.gradient,
    this.boxShadow,
    this.containerColor,
  });
}
