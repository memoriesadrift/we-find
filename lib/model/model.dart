import 'package:we_find/extensions/xml_extensions.dart';
import 'package:we_find/model/I18NString.dart';
import 'package:xml/xml.dart';

class Exam {
  final I18NString? title;
  final Schedule? schedule;
  final List<Lecturer>? examiners;
  final Registrations? registrations;
  final List<Label>? labels;

  Exam.fromXmlTag(XmlElement tag)
      : title = tag.toI18NString("title"),
        schedule = tag.mapDescendant("wwlong", (e) => Schedule.fromXmlTag(e)),
        examiners = tag
            .getElement("examiners")
            ?.mapDescendants("examiner", (e) => Lecturer.fromXmlTag(e)),
        registrations = tag.mapDescendant(
            "registrations", (e) => Registrations.fromXmlTag(e)),
        labels = tag
            .getElement("labels")
            ?.mapDescendants("label", (e) => Label.fromXmlTag(e));
}

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

  Course.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        when = tag.getAttribute("when"),
        version = tag.attrToDateTime("version"),
        longName = tag.toI18NString("longname"),
        courseType = tag.mapDescendant("type", (e) => CourseType.fromXmlTag(e)),
        ects = tag.getElement("ects")?.textToDouble(),
        sws = tag.getElement("sws")?.textToDouble(),
        immanent = tag.getElement("immanent")?.textToBool(),
        chapters = tag
            .getElement("chapters")
            ?.mapDescendants("chapter", (e) => Chapter.fromXmlTag(e)),
        courseOfferee =
            tag.mapDescendant("offeredby", (e) => CourseOfferee.fromXmlTag(e));
}

class CourseType {
  final String? description; // e.g.: Orientierungsveranstaltung
  final String? type; // e.g.: OV

  CourseType.fromXmlTag(XmlElement tag)
      : description = tag.getAttribute("description"),
        type = tag.text;
}

class Chapter {
  final I18NString? category;
  final I18NString? subCategory;

  Chapter.fromXmlTag(XmlElement tag)
      : category = tag.toI18NString("category"),
        subCategory = tag.toI18NString("subcategory");
}

class Group {
  final String? id;
  final bool? vault;
  final String? register;
  final bool? liveStream;
  final int? maxParticipants;
  final List<Language>? languages;
  final Schedule? schedule;
  final List<Lecturer>? lecturers;
  final Registrations? registrations;
  final GeneralInformation? generalInformation;
  final List<Label>? labels;

  Group.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        vault = tag.attrToBool("vault"),
        register = tag.getAttribute("register"),
        liveStream = tag.getElement("livestream")?.textToBool(),
        maxParticipants = tag.getElement("maxparticipants")?.textToInt(),
        languages = tag
            .getElement("languages")
            ?.mapDescendants("language", (e) => Language.fromXmlTag(e)),
        schedule = tag.mapDescendant("wwlong", (e) => Schedule.fromXmlTag(e)),
        lecturers = tag
            .getElement("lecturers")
            ?.mapDescendants("lecturer", (e) => Lecturer.fromXmlTag(e)),
        registrations = tag.mapDescendant(
            "registrations", (e) => Registrations.fromXmlTag(e)),
        generalInformation =
            tag.mapDescendant("info", (e) => GeneralInformation.fromXmlTag(e)),
        labels = tag
            .getElement("labels")
            ?.mapDescendants("label", (e) => Label.fromXmlTag(e));
}

class Language {
  final I18NString? title;
  final String? iso;

  Language.fromXmlTag(XmlElement tag)
      : title = tag.toI18NString("title"),
        iso = tag.getElement("iso")?.text;
}

class Location {
  final String? zip;
  final String? town;
  final String? address;
  final String? room;
  final String? roomExtId;
  final bool? showRoomInfo;

  Location.fromXmlTag(XmlElement tag)
      : zip = tag.getElement("zip")?.text,
        town = tag.getElement("town")?.text,
        address = tag.getElement("address")?.text,
        room = tag.getElement("room")?.text,
        roomExtId = tag.getElement("roomExtId")?.text,
        showRoomInfo = tag.textToBool();
}

class Event {
  final DateTime? begin;
  final DateTime? end;
  final bool? vorbesprechung;
  final Location? location;

  Event.fromXmlTag(XmlElement tag)
      : begin = tag.attrToDateTime("begin"),
        end = tag.attrToDateTime("end"),
        vorbesprechung = tag.attrToBool("vorbesprechung"),
        location = tag.mapDescendant("location", (e) => Location.fromXmlTag(e));
}

class Schedule {
  final I18NString? text;
  final List<Event> events;

  Schedule.fromXmlTag(XmlElement tag)
      : text = tag.toI18NString("wwtext"),
        events = tag.mapDescendants("wwevent", (e) => Event.fromXmlTag(e));
}

class Lecturer {
  final String? id;
  final String? type;
  final String? firstName;
  final String? lastName;

  Lecturer.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        type = tag.getAttribute("type"),
        firstName = tag.getElement("firstname")?.text,
        lastName = tag.getElement("lastname")?.text;
}

class Registrations {
  final DateTime? enrollFrom;
  final DateTime? enrollTo;
  final DateTime? unenrollUntil;

  Registrations.fromXmlTag(XmlElement tag)
      : enrollFrom = tag.getElement("enroll")?.attrToDateTime("from"),
        enrollTo = tag.getElement("enroll")?.attrToDateTime("to"),
        unenrollUntil = tag.getElement("disenroll")?.attrToDateTime("until");
}

class GeneralInformation {
  final I18NString? comment;
  final I18NString? performance;
  final I18NString? literature;
  final I18NString? examination;
  final I18NString? preconditions;

  GeneralInformation.fromXmlTag(XmlElement tag)
      : comment = tag.toI18NString("comment"),
        performance = tag.toI18NString("performance"),
        literature = tag.toI18NString("literature"),
        examination = tag.toI18NString("examination"),
        preconditions = tag.toI18NString("preconditions");
}

class Label {
  final I18NString? id;
  final I18NString? name;

  Label.fromXmlTag(XmlElement tag)
      : id = tag.toI18NString("id"),
        name = tag.toI18NString("name");
}

class Platform {
  final String? type;
  final String? location;

  Platform.fromXmlTag(XmlElement tag)
      : type = tag.getAttribute("type"),
        location = tag.text;
}

class CourseOfferee {
  final String? id;
  final String? name;

  CourseOfferee.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        name = tag.text;
}
