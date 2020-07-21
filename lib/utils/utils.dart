import 'package:flutter/material.dart';

buildTextWidget(String text,
    {Color color = Colors.black,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
    TextAlign textAlign = TextAlign.left}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
  );
}

buildVerticalSpace(double height) {
  return SizedBox(
    height: height,
  );
}
