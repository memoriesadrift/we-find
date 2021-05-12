import 'package:we_find/model/I18NString.dart';

class Course {
  final String? id; // 6-digit course-code, e.g.: 050000
  final String? when; // Semester of course, e.g.: 2021S
  final DateTime? version;
  final I18NString? longName;
  final CourseType? courseType;
  final double? ects;
  final double? sws;
  final bool? immanent;
  final List<Chapter>? chapters;
  final CourseOfferee? courseOfferee;

  Course(this.id, this.when, this.version, this.longName, this.courseType,
      this.ects, this.sws, this.immanent, this.chapters, this.courseOfferee);
}

class CourseType {
  final String? description; // e.g.: Orientierungsveranstaltung
  final String? type; // e.g.: OV

  CourseType(this.description, this.type);
}

class Chapter {
  final I18NString? category;
  final I18NString? subCategory;

  Chapter(this.category, this.subCategory);
}

class Group {
  final String? id;
  final bool? vault;
  final String? register;
  final bool? liveStream;
  final int? maxParticipants;
  final List<Language>? languages;
  final GroupContent? groupContent;
  final List<Lecturer>? lecturers;
  final Registrations? registrations;
  final GeneralInformation? generalInformation;
  final List<Label>? labels;

  Group(
      this.id,
      this.vault,
      this.register,
      this.liveStream,
      this.maxParticipants,
      this.languages,
      this.groupContent,
      this.lecturers,
      this.registrations,
      this.generalInformation,
      this.labels);
}

class Language {
  final I18NString? title;
  final String? iso;

  Language(this.title, this.iso);
}

class Location {
  final String? zip;
  final String? town;
  final String? address;
  final String? room;
  final int? roomExtId;
  final bool? showRoomInfo;

  Location(this.zip, this.town, this.address, this.room, this.roomExtId,
      this.showRoomInfo);
}

class Event {
  final DateTime? begin;
  final DateTime? end;
  final bool? vorbesprechung;

  Event(this.begin, this.end, this.vorbesprechung);
}

class GroupContent {
  final I18NString? text;
  final List<Event>? events;

  GroupContent(this.text, this.events);
}

class Lecturer {
  final String? id;
  final String? type;
  final String? firstName;
  final String? lastName;

  Lecturer(this.id, this.type, this.firstName, this.lastName);
}

class Registrations {
  final DateTime? enrollFrom;
  final DateTime? enrollTo;
  final DateTime? unenrollUntil;

  Registrations(this.enrollFrom, this.enrollTo, this.unenrollUntil);
}

class GeneralInformation {
  final I18NString? comment;
  final I18NString? performance;
  final I18NString? literature;
  final I18NString? examination;
  final I18NString? preconditions;

  GeneralInformation(this.comment, this.performance, this.literature,
      this.examination, this.preconditions);
}

class Label {
  final I18NString? id;
  final I18NString? name;

  Label(this.id, this.name);
}

class Platform {
  final String? type;
  final String? location;

  Platform(this.type, this.location);
}

class CourseOfferee {
  final String? id;
  final String? name;

  CourseOfferee(this.id, this.name);
}