import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/providers/fav_course_provider.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/model_wrapped.dart';
import 'package:we_find/screens/course_detail_screen.dart';
import 'package:we_find/service/ufind_service.dart';

class HeartIcon extends StatefulWidget {
  final Course _myCourse;
  const HeartIcon(this._myCourse);

  @override
  _HeartIconState createState() => _HeartIconState();
}

class _HeartIconState extends State<HeartIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          Provider.of<FavCourseProvider>(context)
                  .courses
                  .contains(widget._myCourse)
              ? Icons.favorite
              : Icons.favorite_outline,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<FavCourseProvider>(context, listen: false)
              .toggleCourseAsFav(widget._myCourse);
        },
      ),
    );
  }
}

class FavouriteTile extends StatelessWidget {
  final BuildContext _context;
  final Course _internalCourse;
  const FavouriteTile(this._context, this._internalCourse);

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final _wrappedCourse = CourseWrapped(_context, _internalCourse);
    final StringConstants constants = StringConstants(context);

    return Container(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: SizedBox(
        width: 150,
        height: 150,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              themeData.colorScheme.primaryVariant,
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
                    actions: <Widget>[HeartIcon(_internalCourse)],
                  ),
                  body: Center(
                    child: FutureBuilder<Course?>(
                      future: fetchCourseById(_wrappedCourse.id),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _wrappedCourse.typeAbbreviation,
                style: themeData.textTheme.button,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Flexible(
                  child: Text(
                    _wrappedCourse.name,
                    style: themeData.textTheme.button,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
