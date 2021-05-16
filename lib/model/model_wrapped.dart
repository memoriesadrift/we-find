import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:we_find/exceptions/exceptions.dart';
import 'package:we_find/model/i18n_string.dart';
import 'package:we_find/model/model.dart';
import 'package:we_find/providers/lang_provider.dart';

// just extend this if you need to access some information
// that is not modeled here. I did not want to add getters for everything

abstract class BaseWrapped {
  final BuildContext context;

  BaseWrapped(this.context);

  Lang getLang() => Provider.of<LangProvider>(context).currentLang;
}

class CourseWrapped {
  final Course _myCourse;
  final Lang _myLang;

  const CourseWrapped(this._myCourse, this._myLang);

  // Think of how to return the name of the requested fields as well,
  // so it's all in one place.
  // e.g.: getCourseName to get the courseName and getCourseNameTitle to get
  // "Course Name" (dependent on language)

  String getTypeAbbreviation() {
    return _myCourse.courseType?.type ?? "--";
  }

  String getName() {
    return _myCourse.longName?.get(_myLang) ?? "Not found";
  }

  String getEcts() {
    return _myCourse.ects?.toString() ?? "Not found";
  }

  List<GroupWrapped> getGroups() {
    List<GroupWrapped> ret = [];
    if (_myCourse.groups == null) {
      return ret;
    }

    for (Group group in _myCourse.groups!) {
      ret.add(GroupWrapped(group, _myLang));
    }

    return ret;
  }
}

class GroupWrapped {
  final Group _myGroup;
  final Lang _myLang;

  const GroupWrapped(this._myGroup, this._myLang);

  String getId() {
    return _myGroup.id ?? "Not found";
  }

  String getMaxParticipants() {
    return _myGroup.maxParticipants?.toString() ?? "unknown";
  }

  String getDescription() {
    return _myGroup.info?.comment?.get(_myLang) ?? "Not found";
  }

  String getMinumumRequirements() {
    return _myGroup.info?.preconditions?.get(_myLang) ?? "Not found";
  }

  ScheduleWrapped getSchedule() {
    if (_myGroup.schedule == null) {
      throw NotFoundException("The group had no schedule");
    }
    return ScheduleWrapped(_myGroup.schedule!);
  }
}

class ScheduleWrapped {
  final Schedule _mySchedule;

  const ScheduleWrapped(this._mySchedule);

  List<EventWrapped> getEvents() {
    List<EventWrapped> ret = [];
    for (Event event in _mySchedule.events) {
      ret.add(EventWrapped(event));
    }
    return ret;
  }
}

class EventWrapped {
  final Event _myEvent;

  const EventWrapped(this._myEvent);

  String getDate() {
    if (_myEvent.begin == null) {
      return "unknown";
    }
    return _myEvent.begin!.day.toString() +
        "." +
        _myEvent.begin!.month.toString() +
        "." +
        _myEvent.begin!.year.toString();
  }

  String getBeginHour() {
    if (_myEvent.begin == null) {
      return "unknown";
    }
    return _myEvent.begin!.hour.toString() +
        ":" +
        _myEvent.begin!.minute.toString();
  }

  String getEndHour() {
    if (_myEvent.end == null) {
      return "unknown";
    }
    return _myEvent.end!.hour.toString() +
        ":" +
        _myEvent.end!.minute.toString();
  }

  String getRoom() {
    //TODO: Maybe change this to be able to show multiple locations?
    // TBH I dont think anybody is going to notice though
    return _myEvent.locations?[0].room ?? "unknown";
  }
}

class StudyModuleWrapped {
  final StudyModule _myStudyModule;
  final Lang _myLang;

  const StudyModuleWrapped(this._myStudyModule, this._myLang);

  String getTitle() {
    return _myStudyModule.title?.get(_myLang) ?? "Title not found";
  }

  List<StudyModuleWrapped> getChildren() {
    List<StudyModuleWrapped> ret = [];
    if (_myStudyModule.submodules == null) {
      return ret;
    }

    for (StudyModule eachStudyMod in _myStudyModule.submodules!) {
      ret.add(StudyModuleWrapped(eachStudyMod, _myLang));
    }

    return ret;
  }
}
