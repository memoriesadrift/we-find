import 'package:flutter/material.dart';
import 'package:we_find/model/model_wrapped.dart';

import '../model/model.dart';

class FavouriteTile extends StatelessWidget {
  final BuildContext _context;
  final Course _internalCourse;
  FavouriteTile(this._context, this._internalCourse) {}

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final _wrappedCourse = CourseWrapped(_context, _internalCourse);
    return SizedBox(
      width: 100,
      height: 100,
      child: Container(
        child: Column(
          children: [
            Text(
              _wrappedCourse.typeAbbreviation,
              style: themeData.textTheme.headline6,
              textAlign: TextAlign.left,
            ),
            Text(
              _wrappedCourse.name,
              style: themeData.textTheme.button,
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}
