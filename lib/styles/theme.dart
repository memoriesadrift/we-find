import 'package:flutter/material.dart';
import 'package:we_find/styles/style_consts.dart' as StyleConsts;

const ColorScheme colorScheme = ColorScheme(
  primary: StyleConsts.Colors.primaryColor,
  primaryVariant: StyleConsts.Colors.primaryColorVariant,
  secondary: StyleConsts.Colors.secondaryColor,
  secondaryVariant: StyleConsts.Colors.secondaryColorVariant,
  surface: StyleConsts.Colors.surfaceColor,
  background: StyleConsts.Colors.backgroundColor,
  error: StyleConsts.Colors.errorColor,
  onPrimary: StyleConsts.Colors.accentColor,
  onSecondary: StyleConsts.Colors.accentColor,
  onSurface: StyleConsts.Colors.accentColor,
  onBackground: StyleConsts.Colors.accentColor,
  onError: StyleConsts.Colors.accentColor,
  brightness: Brightness.light,
);

const TextTheme textTheme = TextTheme(
  headline1: StyleConsts.Text.heading1Style,
  headline2: StyleConsts.Text.heading2Style,
  headline3: StyleConsts.Text.heading3Style,
  headline4: StyleConsts.Text.heading4Style,
  button: StyleConsts.Text.buttonAccentTextStyle,
  bodyText1: StyleConsts.Text.textStyle,
);

ThemeData lightThemeData = ThemeData.from(
  colorScheme: colorScheme,
  textTheme: textTheme,
);
