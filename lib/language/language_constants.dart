import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_find/model/i18n_string.dart';
import 'package:we_find/providers/lang_provider.dart';
import 'package:we_find/screens/advaned_search_screen.dart';

class LanguageConstatnts {
  final BuildContext _context;
  LanguageConstatnts(this._context);

  Lang get lang => Provider.of<LangProvider>(_context).currentLang;
  BuildContext get context => _context;

  // missing data
  String get NotFound => lang == Lang.EN ? "Not Found" : "Nicht gefunden";
  String get Unknown => lang == Lang.EN ? "Unknown" : "Nicht bekannt";
  String get UnknownSemester =>
      lang == Lang.EN ? "Unknown Semester" : "Semester nicht bekannt";
  String get UnknownDepartment =>
      lang == Lang.EN ? "Unknown Department" : "Institut nicht bekannt";
  String get TitleNotFound =>
      lang == Lang.EN ? "Title not found" : "Titel nicht gefunden";

  // advanced search
  String get FuzzySearch => lang == Lang.EN ? "Fuzzy Search" : "Fuzzy Suche";
  String get CourseWithStream =>
      lang == Lang.EN ? "Course with Stream" : "Kurs mit Stream";
  String get OnlyCurrentTerm =>
      lang == Lang.EN ? "Only current term" : "Nur dieses Semester";
  String get SearchByTerm =>
      lang == Lang.EN ? "Search by Term" : "Suche im Semester";
  String get SearchByTermRange =>
      lang == Lang.EN ? "Search by Term Range" : "Suchen in Semesterintervall";
  String get FromTerm => lang == Lang.EN ? "From Term" : "Von Semester";
  String get ToTerm => lang == Lang.EN ? "To Term" : "Bis Semester";

  // search results
  String get SearchResultsFor =>
      lang == Lang.EN ? "Search Results for" : "Suchergebnisse für";
  String get NoResultsFound =>
      lang == Lang.EN ? "No results found" : "Keine Ergebnisse gefunden";

  // advanced search widgets
  String get TermYear => lang == Lang.EN ? "Term year" : "Semesterjahr";
  String get WinterSummerTerm =>
      lang == Lang.EN ? "Winter/Summer term" : "Winter/Sommer Semester";

  // course detail widgets
  String get SelectAGroup =>
      lang == Lang.EN ? "Select a group" : "Wähle eine Gruppe";
  String get MaxParticipants =>
      lang == Lang.EN ? "Max. participants" : "Max. Teilnehmer";
  String get GroupInformation =>
      lang == Lang.EN ? "Group information" : "Gruppeninformation";
  String get Schedule => lang == Lang.EN ? "Schedule" : "Termine";
  String get MinimumRequierments =>
      lang == Lang.EN ? "Minumum requirements" : "Minimalen Voraussetzungen";

  // searchbar
  String get SearchForACourse =>
      lang == Lang.EN ? "Search for a course" : "Suche nach einen Kurz";

  // headers
  String get SearchResults =>
      lang == Lang.EN ? "Search Results" : "Such Ergebnisse";
  String get CourseDirectory =>
      lang == Lang.EN ? "Course Directory" : "Kursverzeichnis";
  String get AdvancedSearch =>
      lang == Lang.EN ? "Advanced Search" : "Erweiterte Suche";
  String get FavoriteCourses =>
      lang == Lang.EN ? "Favorite Courses" : "Lieblings Kurse";
  String get CourseDetail => lang == Lang.EN ? "Course Detail" : "Kursdetails";
}
