import 'package:flutter/material.dart';
import 'package:we_find/model/modelWrapped.dart';
import 'package:we_find/widgets/course_detail_widgets.dart';

class CourseDetailScreen extends StatelessWidget {
  final CourseWrapped _course;
  const CourseDetailScreen(this._course);

  ListView _buildCourseDetailScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    // Title
    view.add(Text(
      _course.getTypeAbbreviation() + " " + _course.getName(),
      style: themeData.textTheme.headline1,
    ));

    // ECTS amount
    view.add(Text(
      "ECTS: " + _course.getEcts(),
      style: themeData.textTheme.headline2,
    ));

    // Groups
    view.add(Padding(
      child: GroupPicker(_course.getGroups()),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));

    return ListView(children: view);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: _buildCourseDetailScreen(context),
    );
  }
}
