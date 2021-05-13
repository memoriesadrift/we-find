import 'package:flutter/material.dart';

class Colors {
  // ignore: unused_element
  Colors._();

  const Colors();

  static const Color primaryColor = const Color(0xFFB80C09);
  static const Color primaryColorVariant = const Color(0xFFD2605F);
  static const Color secondaryColor = const Color(0xFFFFAE03);
  static const Color secondaryColorVariant = const Color(0xFFDBBC77);
  static const Color surfaceColor = const Color(0xFFFFFFFF);
  static const Color backgroundColor = const Color(0xFFFFFFFF);
  static const Color errorColor = const Color(0xFFFFd60A);
  static const Color titleColor = const Color(0xFF5A606B);
  static const Color textColor = const Color(0xFF5A606B);
  static const Color accentColor = const Color(0xFFFFFFFC);
}

const ColorScheme colorScheme = ColorScheme(
    primary: Colors.primaryColor,
    primaryVariant: Colors.primaryColorVariant,
    secondary: Colors.secondaryColor,
    secondaryVariant: Colors.secondaryColorVariant,
    surface: Colors.surfaceColor,
    background: Colors.backgroundColor,
    error: Colors.errorColor,
    onPrimary: Colors.accentColor,
    onSecondary: Colors.accentColor,
    onSurface: Colors.accentColor,
    onBackground: Colors.accentColor,
    onError: Colors.accentColor,
    brightness: Brightness.light);

class Fonts {
  Fonts._();

  const Fonts();

  static const String primaryFontFamily = 'Tajawal';
  static const String fontFamilyFallback = 'Trebuchet MS';
}

class Text {
  // ignore: unused_element
  Text._();

  const Text();

  static const TextStyle titleStyle = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 72,
    color: Colors.titleColor,
  );
  static const TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 12,
    color: Colors.textColor,
  );
  static const TextStyle buttonAccentTextStyle = const TextStyle(
    fontWeight: FontWeight.w200,
    fontSize: 16,
    color: Colors.accentColor,
  );
  static const TextStyle heading1Style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 48,
    color: Colors.textColor,
  );
  static const TextStyle heading2Style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 36,
    color: Colors.textColor,
  );
  static const TextStyle heading3Style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 28,
    color: Colors.textColor,
  );
  static const TextStyle heading4Style = const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 22,
    color: Colors.textColor,
  );
}

const TextTheme textTheme = TextTheme(
  headline1: Text.heading1Style,
  headline2: Text.heading2Style,
  headline3: Text.heading3Style,
  headline4: Text.heading4Style,
  button: Text.buttonAccentTextStyle,
  bodyText1: Text.textStyle,
);

ThemeData lightThemeData = ThemeData.from(
  colorScheme: colorScheme,
  textTheme: textTheme,
);
