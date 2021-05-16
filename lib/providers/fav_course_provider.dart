import 'package:flutter/material.dart';
import 'package:we_find/model/model.dart';

/// Provider that keeps track of the [Course] instances
/// that were marked as favourite by the user
class FavCourseProvider with ChangeNotifier {
  final Set<Course> _courses = {};

  Set<Course> get courses => _courses;

  /// Returns whether the supplied [course] is marked as favourite.
  bool _isFavCourse(Course course) => _courses.contains(course);

  /// Marks the supplied [course] as favourite.
  void _markCourseAsFav(Course course) => _courses.add(course);

  /// Unmarks the supplied [course] as favourite.
  void _unmarkCourseAsFav(Course course) => _courses.remove(course);

  /// Marks the the supplied [course] as favourite if it was not a favourite yet,
  /// else removes it from the favourites.
  void toggleCourseAsFav(Course course) {
    if (_isFavCourse(course))
      _unmarkCourseAsFav(course);
    else
      _markCourseAsFav(course);

    // Let all the attached listeners know that
    // re-rendering the widget tree might be necessary
    notifyListeners();
  }
}
