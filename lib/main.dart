import 'package:flutter/material.dart';
import 'package:we_find/screens/home_screen.dart';
import 'package:we_find/styles/theme.dart' as Theme;

void main() => runApp(WeFindApp());

class WeFindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'we:find',
        theme: Theme.lightThemeData,
        home: HomeScreen());
  }
}
