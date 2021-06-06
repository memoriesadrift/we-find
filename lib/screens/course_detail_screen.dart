import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/widgets/course_detail_widgets.dart';

class CourseDetailScreen extends StatelessWidget {
  final CourseWrapped _course;
  const CourseDetailScreen(this._course);

  ListView _buildCourseDetailScreen(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    List<Widget> view = [];

    // Title
    view.add(Text(
      _course.typeAbbreviation + " " + _course.name,
      style: themeData.textTheme.headline1,
    ));

    // ECTS amount
    view.add(
      Padding(
        padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
        child: Row(
          children: [
            Text(
              "ECTS: " + _course.ects,
              style: themeData.textTheme.headline2,
            ),
            Spacer(),
            Text(
              _course.internalCourse.when ?? "",
              style: themeData.textTheme.headline2,
            ),
          ],
        ),
      ),
    );

    // SPL
    view.add(Padding(
      child: Text(
        _course.offeree,
        style: themeData.textTheme.headline3,
      ),
      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
    ));

    // Groups
    view.add(Padding(
      child: GroupPicker(_course.groups),
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
