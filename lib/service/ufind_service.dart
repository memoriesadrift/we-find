import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:we_find/extensions/string_extensions.dart';
import 'package:we_find/extensions/xml_extensions.dart';
import 'package:we_find/model/model.dart';

const authority = "m1-ufind.univie.ac.at";

/// Returns the root [StudyModule] based on the specified semester [when]
/// and the [spl].
/// Calling [fetchStudyModule('2021S', 5)] would return the root [StudyModule]
/// of the Computer Science faculty of the summer semester 2021.
/// Upon providing a [when] value that is in the future, such as 2030S,
/// the request will be successful, however the returned [StudyModule] will be null.
Future<StudyModule?> fetchStudyModule(String when, int spl) {
  final url = Uri.https(authority, 'courses/browse/$when/$spl');
  return http.get(url).then((response) {
    if (response.statusCode != 200)
      throw new HttpException(
          'Unexpected response status code: ${response.statusCode}');
    final root = response.body.toXmlElement();
    return root.mapDescendant('module', (e) => StudyModule.fromXmlTag(e));
  });
}
