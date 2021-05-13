import 'package:flutter/material.dart';
import 'package:we_find/widgets/course_detail_widgets.dart';

class CourseDetailScreen extends StatelessWidget {
  //TODO: Uncomment this when the Course model is finnished
  // final Course _course;
  // const CourseDetailScreen(this._course);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // title
          Text(
            "VU" + ' ' + "Modelling",
            style: themeData.textTheme.headline1,
          ),
          // subtitle
          Text(
            "ECTS: " + "6.00",
            style: themeData.textTheme.headline2,
          ),
          // somehow add groups
          GroupDetails()
        ],
      ),
    );
  }
}
