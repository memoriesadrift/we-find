import 'package:we_find/extensions/xml_extensions.dart';
import 'package:we_find/model/I18NString.dart';
import 'package:xml/xml.dart';

/// Representation of a [module] tag
/// A [module] tag is a direct descendant of the [structure] tag
/// or of other [module] tags.
class StudyModule {
  final String? id;
  final int? nestLevel;
  final int? spl;
  final Set<String>? path;
  final String? when;
  final String? anchor;
  final StudyModuleLevel? level;
  final StudyModulePredecessor? predecessor;
  final ProgrammeOferee? offeredBy;
  final I18NString? category;
  final I18NString? title;
  final I18NString? comment;
  final List<Course>? courses;
  final List<Exam>? exams;
  final List<StudyModule>? submodules;

  StudyModule.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        nestLevel = tag.attrToInt("level"),
        spl = tag.attrToInt("spl"),
        path = tag.mapAttribute("path", (e) => e.split("|").toSet()),
        when = tag.getAttribute("when"),
        anchor = tag.getAttribute("anchor"),
        level = tag
            .getElement("structure")
            ?.mapDescendant("level", (e) => StudyModuleLevel.fromXmlTag(e)),
        predecessor = tag.mapDescendant(
            "predecessor", (e) => StudyModulePredecessor.fromXmlTag(e)),
        offeredBy = tag.mapDescendant(
            "offeredby", (e) => ProgrammeOferee.fromXmlTag(e)),
        category = tag.toI18NString("category"),
        title = tag.toI18NString("title"),
        comment = tag.toI18NString("comment"),
        courses = tag
            .getElement("courses")
            ?.mapDescendants("course", (e) => Course.fromXmlTag(e)),
        exams = tag
            .getElement("exams")
            ?.mapDescendants("exam", (e) => Exam.fromXmlTag(e)),
        submodules =
            tag.mapDescendants("module", (e) => StudyModule.fromXmlTag(e));
}

/// Representation of a [predecessor] tag
/// A [predecessor] tag is a direct descendant of the [module] tag.
class StudyModulePredecessor {
  final Set<String>? path;
  final String? when;

  StudyModulePredecessor.fromXmlTag(XmlElement tag)
      : path = tag.mapAttribute("path", (e) => e.split("|").toSet()),
        when = tag.getAttribute("when");
}

/// Representation of a [level] tag
/// A [level] tag is a direct descendant of the [structure] tag.
class StudyModuleLevel {
  final int? id;
  final Set<String>? path;
  final I18NString? title;

  StudyModuleLevel.fromXmlTag(XmlElement tag)
      : id = tag.attrToInt("id"),
        path = tag.mapAttribute("path", (e) => e.split("|").toSet()),
        title = tag.toI18NString("title");
}

/// Representation of a [course] tag
/// [course] tags are direct descendants of the 'result' root-tag.
class Course {
  final String? id;
  final String? when;
  final DateTime? version;
  final I18NString? longName;
  final CourseType? courseType;
  final double? ects;
  final double? sws;
  final bool? immanent;
  final List<Chapter>? chapters;
  final List<Group>? groups;
  final ProgrammeOferee? offeredBy;

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
        groups = tag
            .getElement("groups")
            ?.mapDescendants("group", (e) => Group.fromXmlTag(e)),
        offeredBy = tag.mapDescendant(
            "offeredby", (e) => ProgrammeOferee.fromXmlTag(e));

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Course &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          when == other.when;

  @override
  int get hashCode => id.hashCode ^ when.hashCode;
}

/// Representation of a [type] tag
/// A [type] tag is the direct descendant of a [course] tag.
class CourseType {
  final String? description; // e.g.: Orientierungsveranstaltung
  final String? type; // e.g.: OV

  CourseType.fromXmlTag(XmlElement tag)
      : description = tag.getAttribute("description"),
        type = tag.text;
}

/// Representation of a [chapter] tag.
/// [chapter] tags are direct descendants of the 'chapters' tag.
class Chapter {
  final I18NString? category;
  final I18NString? subCategory;
  final I18NString? name;

  Chapter.fromXmlTag(XmlElement tag)
      : category = tag.toI18NString("category"),
        subCategory = tag.toI18NString("subcategory"),
        name = tag.toI18NString("name");
}

/// Representation of a [group] tag.
/// [group] tags are direct descendants of the 'groups' tag.
class Group {
  final String? id;
  final bool? vault;
  final String? register;
  final Platform? platform;
  final bool? liveStream;
  final int? maxParticipants;
  final List<Language>? languages;
  final Schedule? schedule;
  final List<Lecturer>? lecturers;
  final Registrations? registrations;
  final GeneralInformation? info;
  final List<Exam>? exams;
  final List<Label>? labels;

  Group.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        vault = tag.attrToBool("vault"),
        register = tag.getAttribute("register"),
        platform = tag.mapDescendant("platform", (e) => Platform.fromXmlTag(e)),
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
        info =
            tag.mapDescendant("info", (e) => GeneralInformation.fromXmlTag(e)),
        exams = tag
            .getElement("exams")
            ?.mapDescendants("exam", (e) => Exam.fromXmlTag(e)),
        labels = tag
            .getElement("labels")
            ?.mapDescendants("label", (e) => Label.fromXmlTag(e));
}

/// Representation of an [exam] tag.
/// [exam] tags are direct descendants of the [exams] tag.
class Exam {
  final DateTime? begin;
  final DateTime? end;
  final String? id;
  final bool? vault;
  final I18NString? when;
  final I18NString? title;
  final Schedule? schedule;
  final List<Lecturer>? examiners;
  final Registrations? registrations;
  final List<Label>? labels;
  final GeneralInformation? generalInformation;

  Exam.fromXmlTag(XmlElement tag)
      : begin = tag.attrToDateTime("begin"),
        end = tag.attrToDateTime("end"),
        id = tag.getAttribute("id"),
        vault = tag.attrToBool("vault"),
        when = tag.toI18NString("when"),
        title = tag.toI18NString("title"),
        schedule = tag.mapDescendant("wwlong", (e) => Schedule.fromXmlTag(e)),
        examiners = tag
            .getElement("examiners")
            ?.mapDescendants("examiner", (e) => Lecturer.fromXmlTag(e)),
        registrations = tag.mapDescendant(
            "registrations", (e) => Registrations.fromXmlTag(e)),
        labels = tag
            .getElement("labels")
            ?.mapDescendants("label", (e) => Label.fromXmlTag(e)),
        generalInformation =
            tag.mapDescendant("info", (e) => GeneralInformation.fromXmlTag(e));
}

/// Representation of a [platform] tag.
/// [platform] tags are direct descendants of the [group] tag.
class Platform {
  final String? type;
  final String? location;

  Platform.fromXmlTag(XmlElement tag)
      : type = tag.getAttribute("type"),
        location = tag.text;
}

/// Representation of a [language] tag.
/// [language] tags are direct descendants of the [languages] tag.
class Language {
  final I18NString? title;
  final String? iso;

  Language.fromXmlTag(XmlElement tag)
      : title = tag.toI18NString("title"),
        iso = tag.getElement("iso")?.text;
}

/// Representation of a [wwlong] tag
/// A [wwlong] tag is the direct descendant of the [group].
class Schedule {
  final I18NString? text;
  final List<Event> events;

  Schedule.fromXmlTag(XmlElement tag)
      : text = tag.toI18NString("wwtext"),
        events = tag.mapDescendants("wwevent", (e) => Event.fromXmlTag(e));
}

/// Representation of a [wwevent] tag.
/// [wwevent] tags are direct descendants of the [wwlong] tag.
class Event {
  final DateTime? begin;
  final DateTime? end;
  final bool? vorbesprechung;
  final List<Location>? locations;

  Event.fromXmlTag(XmlElement tag)
      : begin = tag.attrToDateTime("begin"),
        end = tag.attrToDateTime("end"),
        vorbesprechung = tag.attrToBool("vorbesprechung"),
        locations =
            tag.mapDescendants("location", (e) => Location.fromXmlTag(e));
}

/// Representation of a [location] tag
/// A [location] tag is the direct descendant of the [wwevent] tag.
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
        roomExtId = tag.getElement("roomextid")?.text,
        showRoomInfo = tag.getElement('showroominfo')?.textToBool();
}

/// Representation of a [lecturer] tag.
/// [lecturer] tags are direct descendants of the [lecturers] tag.
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

/// Representation of a [registration] tag.
/// [registration] tags are direct descendants of the [registrations] tag.
class Registrations {
  final DateTime? enrollFrom;
  final DateTime? enrollTo;
  final DateTime? unenrollUntil;

  Registrations.fromXmlTag(XmlElement tag)
      : enrollFrom = tag.getElement("enroll")?.attrToDateTime("from"),
        enrollTo = tag.getElement("enroll")?.attrToDateTime("to"),
        unenrollUntil = tag.getElement("disenroll")?.attrToDateTime("until");
}

/// Representation of an [info] tag.
/// An [info] tag is the direct descendant of the [course] tag.
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

/// Representation of a [label] tag.
/// [label] tags are direct descendants of the [labels] tag.
class Label {
  final I18NString? id;
  final I18NString? name;

  Label.fromXmlTag(XmlElement tag)
      : id = tag.toI18NString("id"),
        name = tag.toI18NString("name");
}

/// Representation of an [offeredby] tag
/// A [offeredby] tag is the direct descendant of the [course].
class ProgrammeOferee {
  final String? id;
  final String? name;

  ProgrammeOferee.fromXmlTag(XmlElement tag)
      : id = tag.getAttribute("id"),
        name = tag.text;
}
