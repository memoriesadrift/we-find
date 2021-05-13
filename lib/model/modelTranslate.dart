import 'package:we_find/exeptions/exceptions.dart';
import 'package:we_find/model/I18NString.dart';
import 'package:we_find/model/model.dart';

// just extend this if you need to access some information
// that is not modeled here. I did not want to add getters for everything

class CourseTranslate {
  final Course _myCourse;
  final Lang _myLang;
  const CourseTranslate(this._myCourse, this._myLang);

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

  List<GroupTranslate> getGroups() {
    List<GroupTranslate> ret = [];
    if (_myCourse.groups == null) {
      return ret;
    }

    for (Group group in _myCourse.groups!) {
      ret.add(GroupTranslate(group, _myLang));
    }

    return ret;
  }
}

class GroupTranslate {
  final Group _myGroup;
  final Lang _myLang;
  const GroupTranslate(this._myGroup, this._myLang);

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

  ScheduleTranslate getSchedule() {
    if (_myGroup.schedule == null) {
      throw NotFoundException("The group had no schedule");
    }
    return ScheduleTranslate(_myGroup.schedule!);
  }
}

class ScheduleTranslate {
  final Schedule _mySchedule;
  const ScheduleTranslate(this._mySchedule);

  List<EventTranslate> getEvents() {
    List<EventTranslate> ret = [];
    for (Event event in _mySchedule.events) {
      ret.add(EventTranslate(event));
    }
    return ret;
  }
}

class EventTranslate {
  final Event _myEvent;
  const EventTranslate(this._myEvent);

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
