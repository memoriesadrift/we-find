import 'package:flutter/material.dart';

class Colors {
  const Colors();
  static const Color primaryColor = const Color(0xFFB80C09);
  static const Color secondaryColor = const Color(0xFFFFAE03);
  static const Color titleColor = const Color(0xFF5A606B);
  static const Color textColor = titleColor;
  static const Color accentColor = const Color(0xFFFFFFFC);
}

class Text {
  const Text();
  static const TextStyle titleStyle = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 72, color: Colors.titleColor);
  static const TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w200, fontSize: 12, color: Colors.textColor);
  static const TextStyle buttonAccentTextStyle = const TextStyle(
      fontWeight: FontWeight.w200, fontSize: 16, color: Colors.accentColor);
  static const TextStyle heading1Style = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 48, color: Colors.titleColor);
  static const TextStyle heading2Style = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 36, color: Colors.titleColor);
  static const TextStyle heading3Style = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 28, color: Colors.titleColor);
  static const TextStyle heading4Style = const TextStyle(
      fontWeight: FontWeight.w500, fontSize: 22, color: Colors.titleColor);
}
