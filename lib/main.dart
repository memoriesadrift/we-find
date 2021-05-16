import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/providers/fav_course_provider.dart';
import 'package:we_find/providers/lang_provider.dart';
import 'package:we_find/screens/HomeScreen.dart';
import 'package:we_find/styles/theme.dart' as Theme;

void main() => runApp(appProvider(WeFindApp()));

/// Wraps the supplied [appRoot] into a [MultiProvider] that gives access to
/// all the shared states for the Widget-tree.
MultiProvider appProvider(Widget appRoot) => MultiProvider(
      providers: [
        ChangeNotifierProvider<FavCourseProvider>(
          create: (_) => FavCourseProvider(),
        ),
        ChangeNotifierProvider<LangProvider>(
          create: (_) => LangProvider(),
        )
      ],
      child: appRoot,
    );

class WeFindApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'we:find',
      theme: Theme.lightThemeData,
      home: HomeScreen(),
    );
  }
}
