import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  required double fontSize,
  required Color color,
  FontWeight fontWeight = FontWeight.normal,
  TextAlign textAlign = TextAlign.center,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontFamily: 'Poppins',
    ),
  );
}
