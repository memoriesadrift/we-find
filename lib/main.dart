import 'package:flutter/material.dart';
import 'package:we_find/screens/HomeScreen.dart';
import 'package:we_find/styles/theme.dart' as Theme;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'we:find',
        theme: ThemeData(
          primaryColor: Theme.Colors.primaryColor,
        ),
        home: HomeScreen());
  }
}
