import 'dart:io';

import 'package:test/test.dart';
import 'package:we_find/service/ufind_queries.dart';
import 'package:we_find/service/ufind_service.dart';

import '../base_matchers.dart';

void main() {
  group('fetchStudyModule', () {
    test(
        'When entering valid arguments then the value returned from the Future '
        'should not be null', () {
      final validWhen = '2021S';
      final validSpl = 5;
      final studyModuleFuture = fetchStudyModule(validSpl, validWhen);
      expect(studyModuleFuture, completion(isNotNull));
    });
    test(
        'When entering a future semester value and a valid spl then the value '
        'returned from the Future should be null', () {
      final futureWhen = '2030S';
      final validSpl = 5;
      final studyModuleFuture = fetchStudyModule(validSpl, futureWhen);
      expect(studyModuleFuture, completion(isNull));
    });
    test(
        'When entering an invalid semester value and an invalid spl then '
        'an HttpException should be thrown', () {
      final invalidWhen = '2021lol';
      final invalid = -3;
      final studyModuleFuture = fetchStudyModule(invalid, invalidWhen);
      expect(studyModuleFuture, throwsA(const TypeMatcher<HttpException>()));
    });
  });

  group('fetchCourses', () {
    test(
        'When entering a legal query for 10 courses, a list of 10 Course '
        'objects should be returned from the Future', () {
      final query = 'spl5 c:10';
      final coursesFuture = fetchCourses(query);
      expect(coursesFuture, completion(IterableLength(equals(10))));
    });

    test('When entering a nonsense query an empty list should be returned', () {
      final query = 'AaEFdfq2e';
      final coursesFuture = fetchCourses(query);
      expect(coursesFuture, completion(IterableLength(equals(0))));
    });
  });

  group('queryForCourses', () {
    test(
        'When querying for courses with a count argument of 42, '
        '42 results should be returned', () {
      final coursesFuture = queryForCourses('math', queryArgs: [Count(42)]);
      expect(coursesFuture, completion(IterableLength(equals(42))));
    });
  });

  group('fetchRootStudyModules', () {
    test(
        'When fetching modules in a non-future semester, '
        'then a non-empty list of StudyModule objects should be returned', () {
      final studyModulesFuture = fetchRootStudyModules('2021S');
      expect(studyModulesFuture, completion(IterableLength(greaterThan(0))));
    });

    test(
        'When fetching modules in a future semester, '
        'then an empty list of StudyModule objects should be returned', () {
      final studyModulesFuture = fetchRootStudyModules('2028S');
      expect(studyModulesFuture, completion(IterableLength(equals(0))));
    });
  });
}
