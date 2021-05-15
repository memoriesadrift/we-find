import 'package:flutter_test/flutter_test.dart';

class IterableLength extends CustomMatcher {
  IterableLength(matcher) : super('Number of items', 'length', matcher);

  featureValueOf(actual) => (actual as Iterable).length;
}
