import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/providers/fav_course_provider.dart';

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
