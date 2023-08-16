import 'package:flutter/material.dart';

class HexColor {
  static Color getColorFromHex(String hexColor) {
    String newColor = '0xff$hexColor';
    newColor = newColor.replaceAll('#', '');
    int finalColor = int.parse(newColor);
    return Color(finalColor);
  }
}
