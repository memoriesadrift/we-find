import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/providers/fav_course_provider.dart';
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
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(0, 100, 0, 0)),
                // Title
                Align(
                  child: Text(
                    'we:find',
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
                            appBar:
                                AppBar(title: Text(constants.SearchResults)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //direction: Axis.horizontal,
                  // Course directory
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5),
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
                                  appBar: AppBar(
                                      title: Text(constants.CourseDirectory)),
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
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                              Align(
                                child: Icon(
                                  Icons.menu_book,
                                  color: themeData.colorScheme.secondary,
                                  size: 40,
                                ),
                                alignment: Alignment.center,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Align(
                                child: Text(
                                  constants.CourseDirectory,
                                  style: themeData.textTheme.button,
                                ),
                                alignment: Alignment.center,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Advanced search
                    Container(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: ElevatedButton(
                          onPressed: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return Scaffold(
                                  appBar: AppBar(
                                      title: Text(constants.AdvancedSearch)),
                                  body: Center(
                                    child: AdvancedSearchScreen(),
                                  ),
                                );
                              }),
                            )
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              themeData.primaryColor,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
                              Align(
                                child: Icon(
                                  Icons.zoom_in,
                                  color: themeData.colorScheme.secondary,
                                  size: 40,
                                ),
                                alignment: Alignment.center,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
                              Align(
                                child: Text(
                                  constants.AdvancedSearch,
                                  style: themeData.textTheme.button,
                                ),
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    constants.FavoriteCourses,
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
