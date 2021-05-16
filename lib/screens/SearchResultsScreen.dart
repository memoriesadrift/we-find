import 'package:flutter/material.dart';
import 'package:we_find/model/I18NString.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/model/modelWrapped.dart';
import 'package:we_find/widgets/CourseWidget.dart';

class SerchResultScreen extends StatelessWidget {
  final List<CourseWrapped> _myCourses = [];
  SerchResultScreen(List<Course> courses) {
    for (Course eachCourse in courses) {
      // TODO: CHANGE THE LANGUAGE TO SOMETHING MEANINGFULL!
      _myCourses.add(CourseWrapped(eachCourse, Lang.DE));
    }
  }

  ListView _buildSearchResults() {
    List<Widget> view = [];
    for (CourseWrapped eachCourse in _myCourses) {
      view.add(CourseWidget(eachCourse));
      view.add(Divider());
    }
    return ListView(
      children: view,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container();
  }
}
