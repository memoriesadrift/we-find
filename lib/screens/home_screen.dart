import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/providers/fav_course_provider.dart';
import 'package:we_find/providers/lang_provider.dart';
import 'package:we_find/screens/advaned_search_screen.dart';
import 'package:we_find/screens/course_directory_screen.dart';
import 'package:we_find/screens/search_results_screen.dart';
import 'package:we_find/service/ufind_service.dart';
import 'package:we_find/widgets/favourite_tile.dart';
import 'package:we_find/widgets/search_bar.dart';
import 'package:xml/xml.dart';

class HomeScreen extends StatelessWidget {
  // REMOVE NEXT THREE METHODS ONCE PASSING DATA ACTUALLY WORKS
  // ONLY USED TO TEST SOME FUNCTIONALITY
  XmlElement parseXmlString(String string) {
    return XmlDocument.parse(string).rootElement;
  }

  @override
  Widget build(BuildContext context) {
    const String WEFIND_TITLE = 'we:find';
    final ThemeData themeData = Theme.of(context);
    final langProvider = Provider.of<LangProvider>(context);
    final currentLang = langProvider.currentLang;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                // Title
                Align(
                  child: Text(
                    WEFIND_TITLE,
                    style: themeData.textTheme.headline1,
                  ),
                  alignment: Alignment.center,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 0)),
                // Search bar
                Align(
                  child: SearchBar(
                    key: Key('homeScreenSearchBar'),
                    barWidth: MediaQuery.of(context).size.width - 40,
                    barHeight: 80,
                    callbackFunction: (String input) => {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) {
                          return Scaffold(
                            appBar: AppBar(title: Text('Search Results')),
                            body: Center(
                              child: FutureBuilder<List<Course>>(
                                future: fetchCourses(input),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return CircularProgressIndicator();
                                  }
                                  if (snapshot.data != null) {
                                    return SearchResultsScreen(
                                        input, snapshot.data!);
                                  }
                                  throw Exception("don't you dare throw this!");
                                },
                              ),
                            ),
                          );
                        }),
                      )
                    },
                  ),
                  alignment: Alignment.center,
                ),
                Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                // Course directory
                Align(
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: ElevatedButton(
                        // inserting this here, if somebody
                        // wants to offload this somewhere feel free
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return Scaffold(
                                appBar: AppBar(title: Text('Course Directory')),
                                body: Center(
                                  child: FutureBuilder<List<StudyModule>>(
                                    future: fetchRootStudyModules(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      }
                                      if (snapshot.data != null) {
                                        return CourseDirectoryScreen(
                                          snapshot.data!
                                              .map((e) => StudyModuleWrapped(
                                                  context, e))
                                              .toList(),
                                        );
                                      }
                                      throw Exception(
                                          "don't you dare throw this!");
                                    },
                                  ),
                                ),
                              );
                            }),
                          )
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            themeData.primaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                            Align(
                              child: Icon(
                                Icons.menu_book,
                                color: themeData.colorScheme.secondary,
                                size: 40,
                              ),
                              alignment: Alignment.center,
                            ),
                            Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                            Align(
                              child: Text(
                                'Course Directory',
                                style: themeData.textTheme.button,
                              ),
                              alignment: Alignment.center,
                            )
                          ],
                        ),
                      )),
                  alignment: Alignment.center,
                ),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return Scaffold(
                          appBar: AppBar(title: Text('Course Detail Screen')),
                          body: Center(
                            child: AdvancedSearchScreen(),
                          ),
                        );
                      }),
                    )
                  },
                  child: Text(
                    "Test advanced search screen",
                    style: themeData.textTheme.button,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    'Favourite Courses',
                    style: themeData.textTheme.headline3,
                  ),
                )
              ] +
              Provider.of<FavCourseProvider>(context)
                  .courses
                  .map((Course course) => FavouriteTile(context, course))
                  .toList()),
    ));
  }
}
