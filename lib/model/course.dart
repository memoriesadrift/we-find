import 'package:we_find/extensions/xml_extensions.dart';
import 'package:we_find/model/I18NString.dart';
import 'package:xml/xml.dart';

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

  Course.fromXmlElement(XmlElement tag)
      : id = tag.getAttribute("id"),
        when = tag.getAttribute("when"),
        version = tag.attrToDateTime("version"),
        longName = tag.toI18NString("longname"),
        courseType =
            tag.mapDescendant("type", (e) => CourseType.fromXmlElement(e)),
        ects = tag.getElement("ects")?.textToDouble(),
        sws = tag.getElement("sws")?.textToDouble(),
        immanent = tag.getElement("immanent")?.textToBool(),
        chapters = tag
            .getElement("chapters")
            ?.mapDescendants("chapter", (e) => Chapter.fromXmlElement(e)),
        courseOfferee = tag.mapDescendant(
            "offeredby", (e) => CourseOfferee.fromXmlElement(e));
}

class CourseType {
  final String? description; // e.g.: Orientierungsveranstaltung
  final String? type; // e.g.: OV

  CourseType.fromXmlElement(XmlElement tag)
      : description = tag.getAttribute("description"),
        type = tag.text;
}

class Chapter {
  final I18NString? category;
  final I18NString? subCategory;

  Chapter.fromXmlElement(XmlElement tag)
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
  final GroupContent? groupContent;
  final List<Lecturer>? lecturers;
  final Registrations? registrations;
  final GeneralInformation? generalInformation;
  final List<Label>? labels;

  Group.fromXmlElement(XmlElement tag)
      : id = tag.getAttribute("id"),
        vault = tag.attrToBool("vault"),
        register = tag.getAttribute("register"),
        liveStream = tag.getElement("livestream")?.textToBool(),
        maxParticipants = tag.getElement("maxparticipants")?.textToInt(),
        languages = tag
            .getElement("languages")
            ?.mapDescendants("language", (e) => Language.fromXmlElement(e)),
        groupContent =
            tag.mapDescendant("wwlong", (e) => GroupContent.fromXmlElement(e)),
        lecturers = tag
            .getElement("lecturers")
            ?.mapDescendants("lecturer", (e) => Lecturer.fromXmlElement(e)),
        registrations = tag.mapDescendant(
            "registrations", (e) => Registrations.fromXmlElement(e)),
        generalInformation = tag.mapDescendant(
            "info", (e) => GeneralInformation.fromXmlElement(e)),
        labels = tag
            .getElement("labels")
            ?.mapDescendants("label", (e) => Label.fromXmlElement(e));
}

class Language {
  final I18NString? title;
  final String? iso;

  Language.fromXmlElement(XmlElement tag)
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

  Location.fromXmlElement(XmlElement tag)
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

  Event.fromXmlElement(XmlElement tag)
      : begin = tag.attrToDateTime("begin"),
        end = tag.attrToDateTime("end"),
        vorbesprechung = tag.attrToBool("vorbesprechung"),
        location =
            tag.mapDescendant("location", (e) => Location.fromXmlElement(e));
}

class GroupContent {
  final I18NString? text;
  final List<Event> events;

  GroupContent.fromXmlElement(XmlElement tag)
      : text = tag.toI18NString("wwtext"),
        events = tag.mapDescendants("wwevent", (e) => Event.fromXmlElement(e));
}

class Lecturer {
  final String? id;
  final String? type;
  final String? firstName;
  final String? lastName;

  Lecturer.fromXmlElement(XmlElement tag)
      : id = tag.getAttribute("id"),
        type = tag.getAttribute("type"),
        firstName = tag.getElement("firstname")?.text,
        lastName = tag.getElement("lastname")?.text;
}

class Registrations {
  final DateTime? enrollFrom;
  final DateTime? enrollTo;
  final DateTime? unenrollUntil;

  Registrations.fromXmlElement(XmlElement tag)
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

  GeneralInformation.fromXmlElement(XmlElement tag)
      : comment = tag.toI18NString("comment"),
        performance = tag.toI18NString("performance"),
        literature = tag.toI18NString("literature"),
        examination = tag.toI18NString("examination"),
        preconditions = tag.toI18NString("preconditions");
}

class Label {
  final I18NString? id;
  final I18NString? name;

  Label.fromXmlElement(XmlElement tag)
      : id = tag.toI18NString("id"),
        name = tag.toI18NString("name");
}

class Platform {
  final String? type;
  final String? location;

  Platform.fromXmlElement(XmlElement tag)
      : type = tag.getAttribute("type"),
        location = tag.text;
}

class CourseOfferee {
  final String? id;
  final String? name;

  CourseOfferee.fromXmlElement(XmlElement tag)
      : id = tag.getAttribute("id"),
        name = tag.text;
}
