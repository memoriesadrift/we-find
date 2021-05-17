import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/providers/fav_course_provider.dart';
import 'package:we_find/screens/course_detail_screen.dart';
import 'package:we_find/model/model.dart';

class FavouriteTile extends StatelessWidget {
  final BuildContext _context;
  final Course _internalCourse;
  FavouriteTile(this._context, this._internalCourse) {}

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final _wrappedCourse = CourseWrapped(_context, _internalCourse);
    final StringConstants constants = StringConstants(context);
    return Align(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: SizedBox(
          width: 200,
          height: 200,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                themeData.primaryColor,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
            onPressed: () => {
              Navigator.push(
                context,
                MaterialPageRoute<void>(builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(constants.CourseDetail),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(
                            Provider.of<FavCourseProvider>(context)
                                    .courses
                                    .contains(_internalCourse)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Provider.of<FavCourseProvider>(context,
                                    listen: false)
                                .toggleCourseAsFav(_internalCourse);
                          },
                        )
                      ],
                    ),
                    body: Center(
                      child: CourseDetailScreen(_wrappedCourse),
                    ),
                  );
                }),
              )
            },
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Text(
                      _wrappedCourse.typeAbbreviation,
                      style: themeData.textTheme.button,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    _wrappedCourse.name,
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                      color: Color(0xFFFFAE03),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
