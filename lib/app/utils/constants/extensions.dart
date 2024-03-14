import 'package:flutter/material.dart';

extension CustomPaddingX on Widget {
  Padding addPadding(double value) => Padding(
        padding: EdgeInsets.all(value),
        child: this,
      );
}

extension CustomFontSizeX on Text {
  Text withSize(double size) {
    return Text(
      data!,
      style: TextStyle(fontSize: size),
    );
  }
}

extension CustomColor on Text {
  Text addColor(Color? color) {
    return Text(
      data ?? "",
      style: TextStyle(color: color),
    );
  }
}
