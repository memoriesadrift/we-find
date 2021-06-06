import 'package:flutter/material.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/course_detail_screen.dart';
import 'package:we_find/screens/study_module_screen.dart';
import 'package:we_find/service/ufind_service.dart';
import 'package:we_find/widgets/favorite_widgets.dart';

class _helper {
  static void popAll(BuildContext context) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }
}

// This widget handles the actual rendering of the data.
// If you want to customize what it shows you can change the widget argument
class _CourseDirectoryItem extends StatelessWidget {
  final void Function() _onPressed; // function that returns void
  final Widget _display;
  const _CourseDirectoryItem(this._display, this._onPressed);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: Wrap(
        children: [
          TextButton(
            onPressed: _onPressed,
            child: Container(
              width: double.infinity, // 100% width of parent
              child: _display,
            ),
          ),
        ],
      ),
    );
  }
}

// change this class if you want to change how a study module renders
class _StudyModuleItemWidget extends StatelessWidget {
  final StudyModuleWrapped _myStudyModule;
  // function that returns String and takes a string param
  final String Function(String)? _trimName;
  const _StudyModuleItemWidget(this._myStudyModule, this._trimName);

  String _getTrimmedTitle(String title) {
    if (_trimName == null) {
      return title;
    }
    return _trimName!(title);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: Text(
        _getTrimmedTitle(_myStudyModule.title),
        style: themeData.textTheme.headline4,
        textAlign: TextAlign.left,
      ),
    );
  }
}

// Widget, used for rendering the Study modules in the root of the course directory
// These need to dynamicly fetch their children
class CourseDirectoryStudyModuleRootWidget extends StatelessWidget {
  final StudyModuleWrapped _myStudyModule;
  const CourseDirectoryStudyModuleRootWidget(this._myStudyModule);

  String _trimName(String name) {
    if (name.startsWith("Studienprogrammleitung")) {
      return name.substring("Studienprogrammleitung".length + 1);
    }
    if (name.startsWith("Directorate of Studies")) {
      return name.substring("Directorate of Studies".length + 1);
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final StringConstants constants = StringConstants(context);
    return Container(
      child: _CourseDirectoryItem(
        _StudyModuleItemWidget(_myStudyModule, _trimName),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: () => _helper.popAll(context),
                    child: Icon(Icons.home),
                  ),
                  appBar: AppBar(title: Text(constants.CourseDirectory)),
                  body: Center(
                    child: FutureBuilder<StudyModule?>(
                      future: fetchStudyModule(_myStudyModule.splNumber),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        }
                        if (snapshot.data != null) {
                          return StudyModuleScreen(
                            StudyModuleWrapped(context, snapshot.data!),
                          );
                        }
                        throw Exception("don't you dare throw this!");
                      },
                    ),
                  ),
                );
              },
            ),
          )
        },
      ),
    );
  }
}

class CourseDirectoryStudyModuleWidget extends StatelessWidget {
  final StudyModuleWrapped _myStudyModule;
  const CourseDirectoryStudyModuleWidget(this._myStudyModule);

  String _trimName(String name) {
    if (name.endsWith(')')) {
      return name.substring(0, name.lastIndexOf('('));
    }
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);
    return Container(
      child: _CourseDirectoryItem(
        _StudyModuleItemWidget(_myStudyModule, _trimName),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _helper.popAll(context),
                  child: Icon(Icons.home),
                ),
                appBar: AppBar(
                  title: Text(constants.CourseDirectory),
                ),
                body: Center(
                  child: StudyModuleScreen(_myStudyModule),
                ),
              );
            }),
          )
        },
      ),
    );
  }
}

class CourseDirectoryCourseWidget extends StatelessWidget {
  final CourseWrapped _myCourse;
  const CourseDirectoryCourseWidget(this._myCourse);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);
    return Container(
      child: _CourseDirectoryItem(
        Container(
          width: double.infinity,
          child: Text(
            _myCourse.name,
            style: themeData.textTheme.headline4,
            textAlign: TextAlign.left,
          ),
        ),
        () => {
          Navigator.push(
            context,
            MaterialPageRoute<void>(builder: (BuildContext context) {
              return Scaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () => _helper.popAll(context),
                  child: Icon(Icons.home),
                ),
                appBar: AppBar(
                  title: Text(constants.CourseDetail),
                  actions: [HeartIcon(_myCourse.course)],
                ),
                body: Center(
                  child: FutureBuilder<Course?>(
                    future: fetchCourseById(_myCourse.id),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.data != null) {
                        return CourseDetailScreen(
                            CourseWrapped(context, snapshot.data!));
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
    );
  }
}
