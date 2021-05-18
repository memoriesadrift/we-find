import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/providers/fav_course_provider.dart';
import 'package:we_find/providers/lang_provider.dart';
import 'package:we_find/screens/home_screen.dart';
import 'package:we_find/styles/theme.dart' as Theme;

void main() async =>
    runApp(appProvider(WeFindApp(), await _getSavedFavorites()));

Future<Set<CourseID>> _getSavedFavorites() async {
  // obtain shared preferences
  final prefs = await SharedPreferences.getInstance();

  String? favscsv = prefs.getString("favorites");

  if (favscsv == null) return {};

  return favscsv.split(',').map((e) => CourseID(e)).toSet();
}

/// Wraps the supplied [appRoot] into a [MultiProvider] that gives access to
/// all the shared states for the Widget-tree.
MultiProvider appProvider(Widget appRoot, Set<CourseID> favs) => MultiProvider(
      providers: [
        ChangeNotifierProvider<FavCourseProvider>(
          create: (_) => FavCourseProvider(favs),
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
      debugShowCheckedModeBanner: false,
    );
  }
}
