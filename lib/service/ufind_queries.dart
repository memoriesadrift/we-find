/// Fluent API implementation to specify the query arguments to be used
/// when searching for entities exposed by u:find

/// The base class for all query arguments
/// [asString] must be implemented by all subclasses.
abstract class QueryArgument {
  const QueryArgument();

  /// Renders this [QueryArgument] as a [String] that can be used
  /// in the http query parameter.
  String asString();

  /// Joins a specified [searchKeyword] and a list of [QueryArgument] instances
  /// into a single [String] that can be directly used in the http query parameter.
  static String toQueryString(String searchKeyword, List<QueryArgument> args) {
    final joinedArgs = args.map((e) => e.asString()).join(' ');
    return '$searchKeyword $joinedArgs';
  }
}

/// The base class for all query arguments
/// that can be used for general result filtering
abstract class GeneralQueryArgument extends QueryArgument {
  const GeneralQueryArgument();
}

/// Set the number of search results
class Count extends GeneralQueryArgument {
  final int numSearchResults;

  Count(this.numSearchResults);

  @override
  String asString() => 'c:$numSearchResults';
}

/// Exact, non-fuzzy search
const GeneralQueryArgument Exact = _Exact();

class _Exact extends GeneralQueryArgument {
  const _Exact();

  @override
  String asString() => '+exact';
}

/// The base class for all query arguments
/// that can be used when searching for courses
abstract class CourseQueryArgument extends QueryArgument {
  const CourseQueryArgument();
}

/// Filter for courses with streaming
const OffersUStream = _OffersUStream();

class _OffersUStream extends CourseQueryArgument {
  const _OffersUStream();

  @override
  String asString() => 'ustream';
}

/// Search for courses of a certain directorate of studies
class SPL extends CourseQueryArgument {
  final int splNum;

  SPL(this.splNum);

  @override
  String asString() => 'spl$splNum';
}

/// Search for courses in a certain semester
class InSemester extends CourseQueryArgument {
  final String semester;

  InSemester(this.semester);

  @override
  String asString() => '$semester';
}

/// Search for courses in certain semesters
class SemesterRange extends CourseQueryArgument {
  final String startSemester;
  final String endSemester;

  SemesterRange(this.startSemester, this.endSemester);

  @override
  String asString() => '$startSemester-$endSemester';
}

/// Search for courses in the current semester
const CurrentTerm = _CurrentTerm();

class _CurrentTerm extends CourseQueryArgument {
  const _CurrentTerm();

  @override
  String asString() => '+currentterm';
}

/// Search for courses in the current study year
const CurrentYear = _CurrentYear();

class _CurrentYear extends CourseQueryArgument {
  const _CurrentYear();

  @override
  String asString() => '+currentyear';
}

/// Sort search results alphabetically
const SortAlphabetically = _SortAlphabetically();

class _SortAlphabetically extends CourseQueryArgument {
  const _SortAlphabetically();

  @override
  String asString() => '+sort';
}

/// Sort courses by course number
const SortByCourseNumber = _SortByCourseNumber();

class _SortByCourseNumber extends CourseQueryArgument {
  const _SortByCourseNumber();

  @override
  String asString() => '+sortnumber';
}

/// Search for courses by course number
class CourseNumber extends CourseQueryArgument {
  /// 6 digits
  final String number;

  CourseNumber(this.number);

  @override
  String asString() => '$number';
}

/// Search for courses by a partial course number
class PartialCourseNumber extends CourseQueryArgument {
  /// 2-5 digits
  final String number;

  PartialCourseNumber(this.number);

  @override
  String asString() => '$number*';
}
