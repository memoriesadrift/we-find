import 'package:flutter/material.dart';
import 'package:we_find/widgets/course_detail_widgets.dart';

class CourseDetailScreen extends StatelessWidget {
  //TODO: Uncomment this when the Course model is finnished
  // final Course _course;
  // const CourseDetailScreen(this._course);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // title
          Text("VU" + ' ' + "Modelling"),
          // subtitle
          Text("ECTS: " + "6.00"),
          // somehow add groups
          GroupDetails()
        ],
      ),
    );
  }
}
