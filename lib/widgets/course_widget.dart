import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/course_detail_screen.dart';
import 'package:we_find/providers/fav_course_provider.dart';

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
                    appBar: AppBar(
                      title: Text('Course Detail Screen'),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Provider.of<FavCourseProvider>(context)
                                    .courses
                                    .contains(_myCourse.internalCourse)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<FavCourseProvider>(context,
                                    listen: false)
                                .toggleCourseAsFav(_myCourse.internalCourse);
                          },
                        )
                      ],
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
