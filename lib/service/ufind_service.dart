import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:we_find/extensions/string_extensions.dart';
import 'package:we_find/extensions/xml_extensions.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/service/ufind_queries.dart';
import 'package:xml/xml.dart';

const authority = "m1-ufind.univie.ac.at";

/// Returns the root [StudyModule] based on the specified semester [when].
Future<List<StudyModule>> fetchRootStudyModules(String when) {
  final url = Uri.https(authority, 'courses/browse/$when');
  return _fetchXmlContent(
      url,
      (root) =>
          root.mapDescendants('module', (e) => StudyModule.fromXmlTag(e)));
}

/// Returns the root [StudyModule] based on the specified semester [when]
/// and the [spl].
///
/// Calling [fetchStudyModule('2021S', 5)] would return the root [StudyModule]
/// of the Computer Science faculty of the summer semester 2021.
/// Upon providing a [when] value that is in the future, such as 2030S,
/// the request will be successful, however the returned [StudyModule] will be null.
Future<StudyModule?> fetchStudyModule(String when, int spl) {
  final url = Uri.https(authority, 'courses/browse/$when/$spl');
  return _fetchXmlContent(url,
      (root) => root.mapDescendant('module', (e) => StudyModule.fromXmlTag(e)));
}

/// Returns a list of [Course] objects that satisfy the specified [query].
///
/// The [query] needs to be composed as it is described
/// at https://ufind.univie.ac.at/en/help.html.
Future<List<Course>> fetchCourses(String query) {
  final url = Uri.https(authority, 'courses', {'query': query});
  return _fetchXmlContent(url,
      (root) => root.mapDescendants('course', (e) => Course.fromXmlTag(e)));
}

const defaultQueryArgs = <QueryArgument>[];

/// Convenience method to query for courses.
Future<List<Course>> queryForCourses(String searchKeyword,
    {List<QueryArgument> queryArgs = defaultQueryArgs}) {
  final query = QueryArgument.toQueryString(searchKeyword, queryArgs);
  return fetchCourses(query);
}

/// Applies [mapper] to the [XmlElement] retrieved & parsed from the
/// body of the response of the http request sent to [uri].
///
/// Base method that defines how unexpected status codes are handled
/// as well as how the response bodies are decoded.
Future<T> _fetchXmlContent<T>(Uri uri, T Function(XmlElement) mapper) {
  return http.get(uri).then((response) {
    if (response.statusCode != 200)
      throw new HttpException(
          'Unexpected response status code: ${response.statusCode}');
    final root = Utf8Decoder().convert(response.bodyBytes).toXmlElement();
    return mapper(root);
  });
}
