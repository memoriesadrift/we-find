import 'package:flutter_test/flutter_test.dart';
import 'package:we_find/model/i18n_string.dart';

class NumberOfLanguages extends CustomMatcher {
  NumberOfLanguages(matcher)
      : super("Number of supported languages", "map.length", matcher);

  featureValueOf(actual) => (actual as I18NString).map.length;
}
