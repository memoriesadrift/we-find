import 'dart:io';

import 'package:test/test.dart';
import 'package:we_find/service/ufind_service.dart';

void main() {
  group('fetchStudyModule', () {
    test(
        'When entering valid arguments then the value returned from the Future '
        'should not be null', () {
      final validWhen = '2021S';
      final validSpl = 5;
      final studyModuleFuture = fetchStudyModule(validWhen, validSpl);
      expect(studyModuleFuture, completion(isNotNull));
    });
    test(
        'When entering a future semester value and a valid spl then the value '
        'returned from the Future should be null', () {
      final futureWhen = '2030S';
      final validSpl = 5;
      final studyModuleFuture = fetchStudyModule(futureWhen, validSpl);
      expect(studyModuleFuture, completion(isNull));
    });
    test(
        'When entering an invalid semester value and an invalid spl then '
        'an HttpException should be thrown', () {
      final invalidWhen = '2021lol';
      final invalid = -3;
      final studyModuleFuture = fetchStudyModule(invalidWhen, invalid);
      expect(studyModuleFuture, throwsA(const TypeMatcher<HttpException>()));
    });
  });
}
