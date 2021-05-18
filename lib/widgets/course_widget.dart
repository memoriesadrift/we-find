import 'package:flutter/material.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/course_detail_screen.dart';
import 'package:we_find/widgets/favorite_widgets.dart';

class CourseWidget extends StatelessWidget {
  final CourseWrapped _myCourse;
  const CourseWidget(this._myCourse);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final StringConstants constants = StringConstants(context);
    return Container(
      child: Wrap(
        children: [
          TextButton(
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(constants.CourseDetail),
                      actions: [HeartIcon(_myCourse.course)],
                    ),
                    body: Center(
                      child: CourseDetailScreen(_myCourse),
                    ),
                  );
                }),
              )
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Column(children: [
                Row(children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: Text(
                      _myCourse.typeAbbreviation,
                      style: themeData.textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _myCourse.name,
                      style: themeData.textTheme.headline4,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Text(_myCourse.semester),
                ]),
                Padding(padding: EdgeInsets.all(3)),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                      child: Text(
                        _myCourse.ects + " ECTS",
                        style: themeData.textTheme.headline6,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _myCourse.offeree,
                        style: themeData.textTheme.headline6,
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                )
              ]),
            ),
          )
        ],
      ),
    );
  }
}
