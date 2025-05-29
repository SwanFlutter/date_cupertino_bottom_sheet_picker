import 'package:flutter/material.dart';

Widget buildMaterialButton(
    {required double height,
    required double minWidth,
    required Color color,
    required String text,
    required Function() onPressed,
    required TextStyle? style,
    required ShapeBorder? shape}) {
  return MaterialButton(
    height: height,
    minWidth: minWidth,
    color: color,
    shape: const StadiumBorder(),
    onPressed: onPressed,
    child: Text(
      text,
      style: style,
    ),
  );
}
