import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:we_find/exceptions/exceptions.dart';
import 'package:we_find/language/language_constants.dart';
import 'package:we_find/model/i18n_string.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/providers/lang_provider.dart';

/// Base class for all the model wrappers that serve to return data from
/// the model objects even in case of encountering [null] values
abstract class BaseWrapped {
  final BuildContext _context;

  BaseWrapped(this._context);

  BuildContext get context => _context;

  Lang get lang => Provider.of<LangProvider>(_context).currentLang;

  // TODO: Maybe unneccessery to reintialize the object here every time
  StringConstants get constants => StringConstants(_context);
}

class CourseWrapped extends BaseWrapped {
  final Course _course;

  CourseWrapped(BuildContext context, this._course) : super(context);

  Course get course => _course;

  String get id => _course.id ?? constants.Unknown;
  String get offeree => _course.offeredBy?.name ?? constants.UnknownDepartment;

  String get typeAbbreviation => _course.courseType?.type ?? "--";

  String get name => _course.longName?.get(lang) ?? constants.NotFound;

  String get ects => _course.ects?.toString() ?? constants.NotFound;
  String get semester => _course.when ?? constants.UnknownSemester;

  Course get internalCourse => _course;

  List<GroupWrapped> get groups =>
      _course.groups
          ?.map((group) => GroupWrapped(context, group))
          .toList(growable: false) ??
      [];
}

class GroupWrapped extends BaseWrapped {
  final Group _group;

  GroupWrapped(BuildContext context, this._group) : super(context);

  String get id => _group.id ?? constants.NotFound;

  String get maxParticipants =>
      _group.maxParticipants?.toString() ?? constants.Unknown;

  String get description =>
      _group.info?.comment?.get(lang) ?? constants.NotFound;

  String get minumumRequirements =>
      _group.info?.preconditions?.get(lang) ?? constants.NotFound;

  ScheduleWrapped get schedule {
    if (_group.schedule == null)
      throw NotFoundException("The group had no schedule");

    return ScheduleWrapped(context, _group.schedule!);
  }
}

class ScheduleWrapped extends BaseWrapped {
  final Schedule _schedule;

  ScheduleWrapped(BuildContext context, this._schedule) : super(context);

  List<EventWrapped> get events => _schedule.events
      .map((event) => EventWrapped(context, event))
      .toList(growable: false);
}

class EventWrapped extends BaseWrapped {
  final Event _event;

  EventWrapped(BuildContext context, this._event) : super(context);

  String get date {
    if (_event.begin == null) return constants.Unknown;
    final begin = _event.begin!;
    return [begin.day, begin.month, begin.year]
        .map((e) => e.toString())
        .join('.');
  }

  String get beginHour {
    if (_event.begin == null) return constants.Unknown;
    final begin = _event.begin!;
    return [begin.hour, begin.minute].map((e) => e.toString()).join(':');
  }

  String get endHour {
    if (_event.end == null) return constants.Unknown;
    final end = _event.end!;
    return [end.hour, end.minute].map((e) => e.toString()).join(':');
  }

  String get fullEventDate => '$date $beginHour - $endHour';

  String get room => _event.locations?[0].room ?? constants.Unknown;
}

class StudyModuleWrapped extends BaseWrapped {
  final StudyModule _studyModule;

  StudyModuleWrapped(BuildContext context, this._studyModule) : super(context);

  String get term => _studyModule.when ?? constants.Unknown;

  int get splNumber => _studyModule.spl ?? -1;

  String get title => _studyModule.title?.get(lang) ?? constants.Unknown;

  List<CourseWrapped> get courses =>
      _studyModule.courses
          ?.map((course) => CourseWrapped(context, course))
          .toList(growable: false) ??
      []; // returns empty list

  List<StudyModuleWrapped> get children =>
      _studyModule.submodules
          ?.map((studyModule) => StudyModuleWrapped(context, studyModule))
          .toList(growable: false) ??
      []; // returns empty list
}
