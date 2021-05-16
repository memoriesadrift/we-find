import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/course_detail_screen.dart';

class CourseWidget extends StatelessWidget {
  final CourseWrapped _myCourse;
  const CourseWidget(this._myCourse);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      child: Wrap(
        children: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(title: Text('Course Detail Screen')),
                    body: Center(
                      child: CourseDetailScreen(_myCourse),
                    ),
                  );
                }),
              )
            },
            child: Container(
              width: double.infinity,
              child: Text(
                _myCourse.name,
                style: themeData.textTheme.headline4,
                textAlign: TextAlign.left,
              ), // add more text here
            ),
          )
        ],
      ),
    );
  }
}
