import 'package:test/test.dart';
import 'package:we_find/model/model.dart';
import 'package:xml/xml.dart';

import 'model_matchers.dart';

XmlElement parseXmlString(String string) {
  return XmlDocument.parse(string).rootElement;
}

void main() {
  group('CourseOfferee', () {
    final fullTag = parseXmlString(
        '<offeredby id="8505">SPL 5 - Informatik und Wirtschaftsinformatik</offeredby>');
    test(
        "When a CourseOfferee object is created from a full tag, "
        "then all its fields should be non-null", () {
      final obj = CourseOfferee.fromXmlTag(fullTag);
      expect(obj.id, isNotNull, reason: 'id should not be null');
      expect(obj.name, isNotNull, reason: 'name should not be null');
    });
  });

  group("Label", () {
    final fullTag = parseXmlString('''
    <label>
        <id xml:lang="de">VOR-ORT</id>
        <id xml:lang="en">ON-SITE</id>
        <name xml:lang="de">vor Ort</name>
        <name xml:lang="en">on site</name>
      </label>
    ''');
    test(
        "When a Label object is created from a full tag, "
        "then all its I18NString fields should have 2 entries.", () {
      final obj = Label.fromXmlTag(fullTag);
      expect(obj.id, NumberOfLanguages(equals(2)),
          reason: 'id should be available in 2 language(s)');
      expect(obj.name, NumberOfLanguages(equals(2)),
          reason: 'id should be available in 2 language(s)');
    });
  });

  group("GeneralInformation", () {
    final fullTag = parseXmlString('''
    <info>
      <comment xml:lang="de">Ziel des Moduls TGI ist das Kennenlernen und Verstehen der technischen Grundlagen, der Architektur und der allgemeinen Funktionsweise von Computersystemen.&lt;p&#47;&gt;Die Vorlesung gliedert sich in folgende 9 Kapitel:&lt;br&#47;&gt;1. BIT&lt;br&#47;&gt;2. LOGIK&lt;br&#47;&gt;3. TRANSISTOR&lt;br&#47;&gt;4. GATTER&lt;br&#47;&gt;5. SPEICHER&lt;br&#47;&gt;6. PROZESSOR&lt;br&#47;&gt;7. CACHE &amp; Co.&lt;br&#47;&gt;8. ARCHITEKTUR&lt;br&#47;&gt;9. QUANTENCOMPUTING&lt;p&#47;&gt;Zu jedem Kapitel gibt es üblicherweise 4-5 Lernvideos, die von den Studierenden individuell durchgearbeitet und während der gemeinsamen Termine weiter vertieft werden.</comment>
      <performance xml:lang="de">Schriftliche Präsenzprüfung&lt;p&#47;&gt;Als Frageform werden offene Fragen sowie Multiple Choice Fragen eingesetzt.  Es sind keine Unterlagen oder Hilfsmittel erlaubt.&lt;p&#47;&gt;Als Vorbereitung für die Prüfung wird der Besuch der Repetitorien empfohlen, in denen Übungsaufgaben bearbeitet werden, die den Vorlesungsstoff ergänzen. Bitte beachten Sie, dass Sie an den Repetitorien nur teilnehmen können, wenn Sie sich innerhalb der Anmeldefrist in u:space zu einem Repetitorium anmelden.</performance>
      <literature xml:lang="de">VO Folien, die Literaturliste der VO, sowie Literaturangaben, welche explizit auf den Übungsblättern angegeben sind.&lt;p&#47;&gt;Empfohlene Lehrbücher:&lt;br&#47;&gt;Klaus Wüst: Mikroprozessortechnologie, Springer 2011.&lt;br&#47;&gt;Johann Blieberger, Bernd Burgstaller, Gerhard Helge Schildt: Informatik - Grundlagen. Springer 2013.&lt;br&#47;&gt;Dirk W. Hoffmann: Grundlagen der Technischen Informatik. 5. aktualisierte Auflage, Hanser 2016&lt;br&#47;&gt;Matthias Homeister: Quantum Computing verstehen. Springer 2018.</literature>
      <examination xml:lang="de">Prüfungsrelevant ist immer jener Stoff, der im aktuell durchgeführten Lehrveranstaltungszyklus Gegenstand der Lehrveranstaltung ist.  Der Umfang des prüfungsrelevanten Stoffs wird jeweils über die schriftlich bzw. anderweitig verfügbar gemachten LV-Unterlagen definiert. Die Unterlagen zu dieser Lehrveranstaltung bestehen zum einen aus den Lehrveranstaltungsunterlagen wie zum Beispiel Folien und Lernvideos, zum anderen aus Unterlagen in Form der darin referenzierten Literatur. Das erfolgreiche Studium des Lehrinhalts dieser Lehrveranstaltung erfordert auch die eingehende Beschäftigung mit der referenzierten Literatur (Bücher, Papers, etc.).</examination>
      <preconditions xml:lang="de">Mindestanforderung: Erreichen von mind. 50% der erreichbaren Punkte bei der schriftlichen Prüfung (keine Unterlagen erlaubt).&lt;p&#47;&gt;Zur Feststellung der Gesamtnote wird die folgende Notenskala angewendet:&lt;p&#47;&gt;Beurteilungsmaßstab gemäß der erreichten Punkte (Maximalpunktezahl: 70 Punkte)&lt;br&#47;&gt;61 &lt;= P &lt;= 70 Sehr Gut (1)&lt;br&#47;&gt;51 &lt;= P &lt;= 60 Gut (2)&lt;br&#47;&gt;43 &lt;= P &lt;= 50 Befriedigend (3)&lt;br&#47;&gt;35 &lt;= P &lt;= 42 Genügend (4)&lt;br&#47;&gt;0 &lt;= P &lt; 35 Nicht Genügend (5)</preconditions>
    </info>
    ''');
    test(
        "When a GeneralInformation object is created from a full tag with only "
        "german text, then all its I18NString fields should have 1 entries.",
        () {
      final obj = GeneralInformation.fromXmlTag(fullTag);
      expect(obj.comment, NumberOfLanguages(equals(1)),
          reason: 'comment should be available in 1 language(s)');
      expect(obj.performance, NumberOfLanguages(equals(1)),
          reason: 'performance should be available in 1 language(s)');
      expect(obj.literature, NumberOfLanguages(equals(1)),
          reason: 'literature should be available in 1 language(s)');
      expect(obj.examination, NumberOfLanguages(equals(1)),
          reason: 'examination should be available in 1 language(s)');
      expect(obj.preconditions, NumberOfLanguages(equals(1)),
          reason: 'preconditions should be available in 1 language(s)');
    });
  });

  group("Registrations", () {
    final fullTag = parseXmlString('''
    <registrations>
      <enroll from="2021-04-08T08:00:00+02:00" to="2021-05-28T13:00:00+02:00"/>
      <disenroll until="2021-06-04T14:00:00+02:00"/>
    </registrations>
    ''');
    test(
        "When a Registrations object is created from a full tag, "
        "then all its DateTime fields should be non-null.", () {
      final obj = Registrations.fromXmlTag(fullTag);
      expect(obj.enrollFrom, isNotNull,
          reason: 'enrollFrom should not be null');
      expect(obj.enrollTo, isNotNull, reason: 'enrollTo should not be null');
      expect(obj.unenrollUntil, isNotNull,
          reason: 'unenrollUntil should not be null');
    });
  });

  group("Lecturer", () {
    final lecturerTag = parseXmlString('''
    <lecturer id="4236" type="V">
      <firstname>Martin</firstname>
      <lastname>Polaschek</lastname>
    </lecturer>
    ''');
    final examinerTag = parseXmlString('''
    <examiner id="88801">
      <firstname>Andreas</firstname>
      <lastname>Janecek</lastname>
    </examiner>
    ''');
    test(
        "When a Lecturer object is created from a 'lecturer' tag, "
        "then all its fields should be non-null.", () {
      final obj = Lecturer.fromXmlTag(lecturerTag);
      expect(obj.id, isNotNull, reason: 'id should not be null');
      expect(obj.type, isNotNull, reason: 'type should not be null');
      expect(obj.firstName, isNotNull, reason: 'firstName should not be null');
      expect(obj.lastName, isNotNull, reason: 'lastName should not be null');
    });

    test(
        "When a Lecturer object is created from an 'examiner' tag, "
        "then all its fields should be non-null except 'type'.", () {
      final obj = Lecturer.fromXmlTag(examinerTag);
      expect(obj.id, isNotNull, reason: 'id should not be null');
      expect(obj.type, isNull, reason: 'type should be null');
      expect(obj.firstName, isNotNull, reason: 'firstName should not be null');
      expect(obj.lastName, isNotNull, reason: 'lastName should not be null');
    });
  });

  group("Location", () {
    final fullTag = parseXmlString('''
    <location>
      <zip>1090</zip>
      <town>Wien</town>
      <address>Oskar-Morgenstern-Platz 1</address>
      <room>Hörsaal 4  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
      <roomextid>29052</roomextid>
      <showroominfo>true</showroominfo>
    </location>
    ''');
    test(
        "When a Location object is created from a full tag, "
        "then all its fields should be non-null.", () {
      final obj = Location.fromXmlTag(fullTag);
      expect(obj.zip, isNotNull, reason: 'zip should not be null');
      expect(obj.town, isNotNull, reason: 'town should not be null');
      expect(obj.address, isNotNull, reason: 'address should not be null');
      expect(obj.room, isNotNull, reason: 'room should not be null');
      expect(obj.roomExtId, isNotNull, reason: 'roomExtId should not be null');
      expect(obj.showRoomInfo, isNotNull,
          reason: 'showRoomInfo should not be null');
    });
  });

  group("Event", () {
    final fullTag = parseXmlString('''
    <wwevent begin="2021-06-04T15:00:00+02:00" end="2021-06-04T16:30:00+02:00" vorbesprechung="false">
      <location>
          <zip>1190</zip>
          <town>Wien</town>
          <address>Gymnasiumstraße 50</address>
          <room>Audimax Zentrum für Translationswissenschaft, Gymnasiumstraße 50</room>
          <roomextid>22899</roomextid>
          <showroominfo>true</showroominfo>
      </location>
      <location>
          <zip>1090</zip>
          <town>Wien</town>
          <address>Oskar-Morgenstern-Platz 1</address>
          <room>Hörsaal 1  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
          <roomextid>29039</roomextid>
          <showroominfo>true</showroominfo>
      </location>
      <location>
          <zip>1090</zip>
          <town>Wien</town>
          <address>Oskar-Morgenstern-Platz 1</address>
          <room>Hörsaal 4  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
          <roomextid>29052</roomextid>
          <showroominfo>true</showroominfo>
      </location>
  </wwevent>
    ''');
    test(
        "When an Event object is created from a full tag of 3 locations, "
        "then all its fields should be non-null and "
        "the locations list should have a length of 3", () {
      final obj = Event.fromXmlTag(fullTag);
      expect(obj.begin, isNotNull, reason: 'begin should not be null');
      expect(obj.end, isNotNull, reason: 'end should not be null');
      expect(obj.vorbesprechung, isNotNull,
          reason: 'vorbesprechung should not be null');
      expect(obj.locations, isNotNull, reason: 'locations should not be null');
      expect(obj.locations!.length, equals(3),
          reason: 'locations should have a length of 3');
    });
  });

  group("Schedule", () {
    final fullTag = parseXmlString('''
    <wwlong>
      <wwevent begin="2021-03-08T09:45:00+01:00" end="2021-03-08T11:15:00+01:00" vorbesprechung="false">
        <location>
          <zip>1010</zip>
          <town>Wien</town>
          <address>(Universitätsstraße 1)</address>
          <room>Digital</room>
          <roomextid>31477</roomextid>
          <showroominfo>true</showroominfo>
        </location>
      </wwevent>
    </wwlong>
    ''');

    test(
        "When a Schedule object is created from a full tag of 1 events, "
        "then all its fields should be non-null except text "
        "the events list should have a length of 1", () {
      final obj = Schedule.fromXmlTag(fullTag);
      expect(obj.text, isNull, reason: 'text should be null');
      expect(obj.events.length, equals(1),
          reason: 'events should have a length of 3');
    });
  });

  group("Language", () {
    final fullTag = parseXmlString('''
    <language>
      <title xml:lang="de">Deutsch</title>
      <title xml:lang="en">German</title>
      <iso>de</iso>
    </language>
    ''');
    test(
        "When a Language object is created from a full tag with emglish and "
        "german text, then all its I18NString fields should have 2 entries "
        "and all the fields should be non-null.", () {
      final obj = Language.fromXmlTag(fullTag);
      expect(obj.title, isNotNull, reason: 'title should not be null');
      expect(obj.title, NumberOfLanguages(equals(2)),
          reason: 'title should be available in 2 language(s)');
      expect(obj.iso, isNotNull, reason: 'iso should not be null');
    });
  });

  group("Platform", () {
    final fullTag = parseXmlString('''
    <platform type="CEWebs">https:&#47;&#47;cewebs.cs.univie.ac.at&#47;inter&#47;course&#47;view.php?id=2000653</platform>
    ''');
    test(
        "When a Platform object is created from a full tag, "
        "then all its fields should be non-null.", () {
      final obj = Platform.fromXmlTag(fullTag);
      expect(obj.type, isNotNull, reason: 'enrollFrom should not be null');
      expect(obj.location, isNotNull, reason: 'enrollTo should not be null');
    });
  });

  group("Exam", () {
    final fullTag = parseXmlString('''
    <exam begin="2021-06-04T15:00:00+02:00" end="2021-06-04T16:30:00+02:00" id="1224844" extid="1228161" vault="false">
      <title xml:lang="en">Technical Foundations of Computer Science</title>
      <title xml:lang="de">Technische Grundlagen der Informatik</title>
      <when xml:lang="de">UPDATE 15.04.2021: Achtung - gemäß Bekanntgabe des Rektorats vom 15.04.2021 sind COVID-19-Eintrittstests für diese Prüfung erforderlich. Sie finden alle Informationen auf &lt;a href=&#39;http:&#47;&#47;studieren.univie.ac.at&#47;info.&#39;&gt;http:&#47;&#47;studieren.univie.ac.at&#47;info.&lt;&#47;a&gt;</when>
      <asexcluded>false</asexcluded>
      <wwlong>
          <wwevent begin="2021-06-04T15:00:00+02:00" end="2021-06-04T16:30:00+02:00" vorbesprechung="false">
              <location>
                  <zip>1190</zip>
                  <town>Wien</town>
                  <address>Gymnasiumstraße 50</address>
                  <room>Audimax Zentrum für Translationswissenschaft, Gymnasiumstraße 50</room>
                  <roomextid>22899</roomextid>
                  <showroominfo>true</showroominfo>
              </location>
              <location>
                  <zip>1090</zip>
                  <town>Wien</town>
                  <address>Oskar-Morgenstern-Platz 1</address>
                  <room>Hörsaal 1  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
                  <roomextid>29039</roomextid>
                  <showroominfo>true</showroominfo>
              </location>
              <location>
                  <zip>1090</zip>
                  <town>Wien</town>
                  <address>Oskar-Morgenstern-Platz 1</address>
                  <room>Hörsaal 4  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
                  <roomextid>29052</roomextid>
                  <showroominfo>true</showroominfo>
              </location>
          </wwevent>
      </wwlong>
      <examiners>
          <examiner id="88801">
              <firstname>Andreas</firstname>
              <lastname>Janecek</lastname>
          </examiner>
          <examiner id="50498">
              <firstname>Peter</firstname>
              <lastname>Reichl</lastname>
          </examiner>
      </examiners>
      <registrations>
          <enroll from="2021-04-08T08:00:00+02:00" to="2021-05-28T13:00:00+02:00"/>
          <disenroll until="2021-06-04T14:00:00+02:00"/>
      </registrations>
      <labels>
          <label>
              <id xml:lang="de">VOR-ORT</id>
              <id xml:lang="en">ON-SITE</id>
              <name xml:lang="de">vor Ort</name>
              <name xml:lang="en">on site</name>
          </label>
      </labels>
      <info></info>
  </exam>
    ''');
    test(
        "When an Exam object is created from a full tag, with 1 Event, 2 Examiners and 1 Label "
        "then all its fields should be non-null. And its list fields should have proper lengths",
        () {
      final obj = Exam.fromXmlTag(fullTag);
      expect(obj.begin, isNotNull, reason: 'begin should not be null');
      expect(obj.end, isNotNull, reason: 'end should not be null');
      expect(obj.id, isNotNull, reason: 'id should not be null');
      expect(obj.vault, isNotNull, reason: 'vault should not be null');
      expect(obj.title, isNotNull, reason: 'title should not be null');
      expect(obj.when, isNotNull, reason: 'when should not be null');
      expect(obj.schedule, isNotNull, reason: 'schedule should not be null');
      expect(obj.schedule!.events.length, equals(1),
          reason: 'schedule.events should have a length of 1');
      expect(obj.examiners, isNotNull, reason: 'examiners should not be null');
      expect(obj.examiners!.length, equals(2),
          reason: 'examiners should have a length of 2');
      expect(obj.registrations, isNotNull,
          reason: 'registrations should not be null');
      expect(obj.labels, isNotNull, reason: 'labels should not be null');
      expect(obj.labels!.length, equals(1),
          reason: 'labels should have a length of 1');
      expect(obj.generalInformation, isNotNull,
          reason: 'generalInformation should not be null');
    });
  });

  group("Group", () {
    final fullTag = parseXmlString('''
    <group vault="false" id="051010-1" register="878430">
        <platform type="CEWebs">https:&#47;&#47;cewebs.cs.univie.ac.at&#47;inter&#47;course&#47;view.php?id=2000653</platform>
        <livestream>false</livestream>
        <maxparticipants>50</maxparticipants>
        <languages>
            <language>
                <title xml:lang="de">Deutsch</title>
                <title xml:lang="en">German</title>
                <iso>de</iso>
            </language>
        </languages>
        <wwlong>
            <wwevent begin="2021-06-18T09:45:00+02:00" end="2021-06-18T13:00:00+02:00" vorbesprechung="false">
                <location>
                    <zip>1010</zip>
                    <town>Wien</town>
                    <address>(Universitätsstraße 1)</address>
                    <room>Digital</room>
                    <roomextid>31477</roomextid>
                    <showroominfo>true</showroominfo>
                </location>
            </wwevent>
            <wwevent begin="2021-06-22T15:00:00+02:00" end="2021-06-22T18:00:00+02:00" vorbesprechung="false">
                <location>
                    <zip>1010</zip>
                    <town>Wien</town>
                    <address>(Universitätsstraße 1)</address>
                    <room>Digital</room>
                    <roomextid>31477</roomextid>
                    <showroominfo>true</showroominfo>
                </location>
            </wwevent>
            <wwevent begin="2021-06-25T09:45:00+02:00" end="2021-06-25T13:00:00+02:00" vorbesprechung="false">
                <location>
                    <zip>1010</zip>
                    <town>Wien</town>
                    <address>(Universitätsstraße 1)</address>
                    <room>Digital</room>
                    <roomextid>31477</roomextid>
                    <showroominfo>true</showroominfo>
                </location>
            </wwevent>
        </wwlong>
        <lecturers>
            <lecturer id="9678" type="V">
                <firstname>Manfred</firstname>
                <lastname>Schüttengruber</lastname>
            </lecturer>
            <lecturer id="27968" type="P">
                <firstname>Reinhold</firstname>
                <lastname>Dunkl</lastname>
            </lecturer>
        </lecturers>
        <registrations>
            <enroll from="2021-02-15T09:00:00+01:00" to="2021-02-22T09:00:00+01:00"/>
            <disenroll until="2021-03-14T23:59:00+01:00"/>
        </registrations>
        <info>
            <comment xml:lang="de">Für die Lehrveranstaltung werden keinerlei Programmierkenntnisse vorausgesetzt. Folgende Kenntnisse sind im Lauf des Semesters zu erwerben:&lt;p&#47;&gt;Grundkenntnisse über Algorithmen und Programmierung digitaler Rechner&lt;br&#47;&gt;Daten, Algorithmen, Programmiersprachen, Programme - eine begriffliche Einführung&lt;br&#47;&gt;Grundlagen der imperativen Programmierung&lt;br&#47;&gt;Grundlagen der objektorientierten Programmierung&lt;p&#47;&gt;In der Vorlesung werden die Stoffinhalte in Form eines Frontalvortrags vermittelt. In den Übungseinheiten werden die erworbenen Kenntnisse praktisch umgesetzt, indem Programme zu vorgegebenen Problemstellungen erstellt werden.&lt;p&#47;&gt;Vorlesung und Übungseinheiten finden in Form von Online-Sitzungen statt.</comment>
            <performance xml:lang="de">Theoretische Prüfung (Test), bei der die Fähigkeit, vorgegebene Programme zu lesen und zu verstehen, überprüft wird. Der Test besteht aus 15 Fragen, die jeweils mit zwei Punkten bewertet werden. Für den Test werden somit bis zu 30 Punkte vergeben. Der Test kann am Ende des Semesters (Haupttermin) oder im Rahmen von zwei Nachterminen zu Beginn bzw. am Ende der lehrveranstaltungsfreien Zeit absolviert werden. Das beste Ergebnis wird gewertet.&lt;p&#47;&gt;Praktische Prüfung (Abschlussklausur), in deren Rahmen ein funktionierendes Programm für eine vorgegebene Problemstellung am Rechner erstellt werden muss. Für die Abschlussklausur werden bis zu 55 Punkte vergeben. Die Abschlussklausur kann am Semesterende (Haupttermin) oder zu Beginn bzw. am Ende der lehrveranstaltungsfreien Zeit (1. und 2. Nachtermin) absolviert werden. Das beste Ergebnis wird bewertet.&lt;p&#47;&gt;Wöchentlich werden Hausaufgaben gestellt, in deren Rahmen einfache Programme zu entwickeln sind. Für die regelmäßige Abgabe gelöster Hausübungsbeispiele können im Lauf des Semesters bis zu 15 Punkte erreicht werden.&lt;p&#47;&gt;Insgesamt können 100 Punkte (30 Testpunkte, 15 Hausübungspunkte und 55 Abschlussklausurpunkte) erreicht werden.&lt;p&#47;&gt;Zusatzpunkte: Im Lauf des Semesters finden zur Vorbereitung auf den Test drei optionale Zwischentests statt, die ebenfalls jeweils aus 15 Fragen bestehen. Die korrekt beantworteten Fragen können im Verhältnis 1 zu 9 auf Bonuspunkte umgerechnet werden. Es ist somit ein Maximum an 5 Bonuspunkten erreichbar.&lt;p&#47;&gt;Test und Abschlussklausur finden vor Ort in den Rechnerlabors statt.&lt;p&#47;&gt;Beim Test sind keinerlei Unterlagen zugelassen, bei der Abschlussklausur nur die von der LV-Leitung für die Prüfung zur Verfügung gestellten bzw. freigegebenen Unterlagen. Die Hausübungen sind auf Basis der in der Lernplattform zur Verfügung gestellten Unterlagen und der angeführten Literatur zu erstellen.</performance>
            <literature xml:lang="de">Bjarne Stroustrup: Programming  Principles and Practice Using C++ (2nd Edition), Addison Wesley.</literature>
            <examination xml:lang="de">Prüfungsstoff ist der gesamte  Stoffinhalt der Lehrveranstaltung.</examination>
            <preconditions xml:lang="de">Notwendige Bedingungen für eine positive Beurteilung sind:&lt;br&#47;&gt;1) Ein lauffähiges und die Aufgabenstellung erfüllendes Programm (entspricht 30 Punkten) bei der Abschlussklausur&lt;br&#47;&gt;2) Mindestens 12 Punkte beim Test&lt;br&#47;&gt;3) Mindestens 7 Punkte für gelöste Hausübungsbeispiele&lt;p&#47;&gt;Sind die Mindestanforderungen erfüllt, werden die Punkte der Abschlussklausur, die erreichten Test- und Hausübungspunkte sowie eventuell erzielte Bonuspunkte addiert. Die Note ergibt sich aus den insgesamt erreichten Punkten nach folgendem Schlüssel:&lt;p&#47;&gt;&gt;= 87,5 Punkte    sehr gut (1)&lt;br&#47;&gt;&gt;= 75    Punkte    gut (2)&lt;br&#47;&gt;&gt;= 62,5 Punkte    befriedigend (3)&lt;br&#47;&gt;&gt;= 50    Punkte    genügend (4)&lt;br&#47;&gt;&lt; 50      Punkte    nicht genügend (5)&lt;p&#47;&gt;Achtung: die notwendigen Kriterien sind nicht hinreichend für eine positive Beurteilung</preconditions>
        </info>
        <exams>
          <exam begin="2021-06-04T15:00:00+02:00" end="2021-06-04T16:30:00+02:00" id="1224844" extid="1228161" vault="false">
              <title xml:lang="en">Technical Foundations of Computer Science</title>
              <title xml:lang="de">Technische Grundlagen der Informatik</title>
              <when xml:lang="de">UPDATE 15.04.2021: Achtung - gemäß Bekanntgabe des Rektorats vom 15.04.2021 sind COVID-19-Eintrittstests für diese Prüfung erforderlich. Sie finden alle Informationen auf &lt;a href=&#39;http:&#47;&#47;studieren.univie.ac.at&#47;info.&#39;&gt;http:&#47;&#47;studieren.univie.ac.at&#47;info.&lt;&#47;a&gt;</when>
              <asexcluded>false</asexcluded>
              <wwlong>
                  <wwevent begin="2021-06-04T15:00:00+02:00" end="2021-06-04T16:30:00+02:00" vorbesprechung="false">
                      <location>
                          <zip>1190</zip>
                          <town>Wien</town>
                          <address>Gymnasiumstraße 50</address>
                          <room>Audimax Zentrum für Translationswissenschaft, Gymnasiumstraße 50</room>
                          <roomextid>22899</roomextid>
                          <showroominfo>true</showroominfo>
                      </location>
                      <location>
                          <zip>1090</zip>
                          <town>Wien</town>
                          <address>Oskar-Morgenstern-Platz 1</address>
                          <room>Hörsaal 1  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
                          <roomextid>29039</roomextid>
                          <showroominfo>true</showroominfo>
                      </location>
                      <location>
                          <zip>1090</zip>
                          <town>Wien</town>
                          <address>Oskar-Morgenstern-Platz 1</address>
                          <room>Hörsaal 4  Oskar-Morgenstern-Platz 1  Erdgeschoß</room>
                          <roomextid>29052</roomextid>
                          <showroominfo>true</showroominfo>
                      </location>
                  </wwevent>
              </wwlong>
              <examiners>
                  <examiner id="88801">
                      <firstname>Andreas</firstname>
                      <lastname>Janecek</lastname>
                  </examiner>
                  <examiner id="50498">
                      <firstname>Peter</firstname>
                      <lastname>Reichl</lastname>
                  </examiner>
              </examiners>
              <registrations>
                  <enroll from="2021-04-08T08:00:00+02:00" to="2021-05-28T13:00:00+02:00"/>
                  <disenroll until="2021-06-04T14:00:00+02:00"/>
              </registrations>
              <labels>
                  <label>
                      <id xml:lang="de">VOR-ORT</id>
                      <id xml:lang="en">ON-SITE</id>
                      <name xml:lang="de">vor Ort</name>
                      <name xml:lang="en">on site</name>
                  </label>
              </labels>
              <info></info>
          </exam>
          <exam begin="2021-06-28T13:15:00+02:00" end="2021-06-28T14:45:00+02:00" id="1225795" extid="1229084" vault="false">
              <title xml:lang="en">Technical Foundations of Computer Science</title>
              <title xml:lang="de">Technische Grundlagen der Informatik</title>
              <when xml:lang="de">UPDATE 15.04.2021: Achtung - gemäß Bekanntgabe des Rektorats vom 15.04.2021 sind COVID-19-Eintrittstests für diese Prüfung erforderlich. Sie finden alle Informationen auf &lt;a href=&#39;http:&#47;&#47;studieren.univie.ac.at&#47;info.&#39;&gt;http:&#47;&#47;studieren.univie.ac.at&#47;info.&lt;&#47;a&gt;</when>
              <asexcluded>false</asexcluded>
              <wwlong>
                  <wwevent begin="2021-06-28T13:15:00+02:00" end="2021-06-28T14:45:00+02:00" vorbesprechung="false">
                      <location>
                          <zip>1190</zip>
                          <town>Wien</town>
                          <address>Gymnasiumstraße 50</address>
                          <room>Audimax Zentrum für Translationswissenschaft, Gymnasiumstraße 50</room>
                          <roomextid>22899</roomextid>
                          <showroominfo>true</showroominfo>
                      </location>
                  </wwevent>
              </wwlong>
              <examiners>
                  <examiner id="88801">
                      <firstname>Andreas</firstname>
                      <lastname>Janecek</lastname>
                  </examiner>
                  <examiner id="50498">
                      <firstname>Peter</firstname>
                      <lastname>Reichl</lastname>
                  </examiner>
              </examiners>
              <registrations>
                  <enroll from="2021-04-22T08:00:00+02:00" to="2021-06-21T13:00:00+02:00"/>
                  <disenroll until="2021-06-28T12:15:00+02:00"/>
              </registrations>
              <labels>
                  <label>
                      <id xml:lang="de">VOR-ORT</id>
                      <id xml:lang="en">ON-SITE</id>
                      <name xml:lang="de">vor Ort</name>
                      <name xml:lang="en">on site</name>
                  </label>
              </labels>
              <info></info>
          </exam>
        </exams>
        <labels>
            <label>
                <id xml:lang="de">VOR-ORT</id>
                <id xml:lang="en">ON-SITE</id>
                <name xml:lang="de">vor Ort</name>
                <name xml:lang="en">on site</name>
            </label>
        </labels>
    </group>
    ''');
    test(
        "When a Group object is created from a full tag, with 1 Language, "
        "3 Events, 2 Lecturers 2 exams and 1 Label then all its fields should be non-null. "
        "And its list fields should have proper lengths", () {
      final obj = Group.fromXmlTag(fullTag);
      expect(obj.platform, isNotNull, reason: 'platform should not be null');
      expect(obj.liveStream, isNotNull,
          reason: 'liveStream should not be null');
      expect(obj.maxParticipants, isNotNull,
          reason: 'maxParticipants should not be null');
      expect(obj.languages, isNotNull, reason: 'languages should not be null');
      expect(obj.languages!.length, equals(1),
          reason: 'languages should have a length of 1');
      expect(obj.schedule, isNotNull, reason: 'schedule should not be null');
      expect(obj.schedule!.events.length, equals(3),
          reason: 'schedule.events should have a length of 3');
      expect(obj.lecturers, isNotNull, reason: 'lecturers should not be null');
      expect(obj.lecturers!.length, equals(2),
          reason: 'lecturers should have a length of 2');
      expect(obj.registrations, isNotNull,
          reason: 'registrations should not be null');
      expect(obj.generalInformation, isNotNull,
          reason: 'generalInformation should not be null');
      expect(obj.exams, isNotNull, reason: 'exams should not be null');
      expect(obj.exams!.length, equals(2),
          reason: 'exams should have a length of 2');
      expect(obj.labels, isNotNull, reason: 'labels should not be null');
      expect(obj.labels!.length, equals(1),
          reason: 'labels should have a length of 1');
    });
  });

  group("Course", () {
    final fullTag = parseXmlString('''
    <course id="050000" when="2021S" version="2021-04-21T11:25:54+02:00">
        <longname xml:lang="de">Orientierungsveranstaltung</longname>
        <longname xml:lang="en">Orientation course</longname>
        <type desc="Orientierungsveranstaltung">OV</type>
        <ects>0.00</ects>
        <sws>0.50</sws>
        <immanent>false</immanent>
        <asexcluded>true</asexcluded>
        <chapters>
            <codes>Module: OV</codes>
            <chapter path="250876|259075|259141|259672">
                <category xml:lang="de" path="250876|259075|259141">Bachelor Wirtschaftsinformatik 2016 (526 [3])</category>
                <category xml:lang="en" path="250876|259075|259141">Bachelor Business Informatics 2016 (526 [3])</category>
                <subcategory xml:lang="de" path="250876|259075|259141|259672">Orientierungsveranstaltung</subcategory>
                <name xml:lang="de">Orientierungsveranstaltung</name>
            </chapter>
            <chapter path="250876|259075|259109|259673">
                <category xml:lang="de" path="250876|259075|259109">Bachelor Lehramt UF Informatik (193 053 [1], 198 414 [1])</category>
                <category xml:lang="en" path="250876|259075|259109">Teacher Training Programme - Bachelor Computer Science (193 053 [1], 198 414 [1])</category>
                <subcategory xml:lang="de" path="250876|259075|259109|259673">Orientierungsveranstaltung</subcategory>
                <subcategory xml:lang="en" path="250876|259075|259109|259673">Orientation course</subcategory>
                <name xml:lang="de">Orientierungsveranstaltung</name>
                <name xml:lang="en">Orientation course</name>
            </chapter>
        </chapters>
        <groups count="1">
            <group vault="false" id="050000-1" register="878427">
                <livestream>false</livestream>
                <maxparticipants>0</maxparticipants>
                <languages>
                    <language>
                        <title xml:lang="de">Deutsch</title>
                        <title xml:lang="en">German</title>
                        <iso>de</iso>
                    </language>
                </languages>
                <wwlong>
                    <wwtext xml:lang="de">Die Orientierungsveranstaltung wird digital stattfinden. &lt;a href=&#39;https:&#47;&#47;bbb.cs.univie.ac.at&#47;b&#47;mar-9oo-njj-tzw&#39;&gt;https:&#47;&#47;bbb.cs.univie.ac.at&#47;b&#47;mar-9oo-njj-tzw&lt;&#47;a&gt;</wwtext>
                    <wwevent begin="2021-03-08T09:45:00+01:00" end="2021-03-08T11:15:00+01:00" vorbesprechung="false">
                        <location>
                            <zip>1010</zip>
                            <town>Wien</town>
                            <address>(Universitätsstraße 1)</address>
                            <room>Digital</room>
                            <roomextid>31477</roomextid>
                            <showroominfo>true</showroominfo>
                        </location>
                    </wwevent>
                </wwlong>
                <lecturers>
                    <lecturer id="4236" type="V">
                        <firstname>Martin</firstname>
                        <lastname>Polaschek</lastname>
                    </lecturer>
                </lecturers>
                <registrations></registrations>
                <info>
                    <comment xml:lang="de">Orientierungsveranstaltung gem. §60 Abs 1b UG:&lt;p&#47;&gt;Zur studienvorbereitenden und studienbegleitenden Beratung ist anlässlich der Zulassung zum Diplom- oder Bachelorstudium für die Abhaltung von Orientierungsveranstaltungen zu sorgen, in deren Rahmen&lt;p&#47;&gt;1. die Studierenden in geeigneter Form über&lt;p&#47;&gt;a) die wesentlichen Bestimmungen des Universitätsrechts und des Studienförderungsrechts,&lt;br&#47;&gt;b) die studentische Mitbestimmung in den Organen der Universität,&lt;br&#47;&gt;c) die Rechtsgrundlagen der Frauenförderung,&lt;br&#47;&gt;d) den gesetzlichen Diskriminierungsschutz,&lt;br&#47;&gt;e) das Curriculum,&lt;br&#47;&gt;f) das Qualifikationsprofil der Absolvent*innen,&lt;br&#47;&gt;g) die Studieneingangs- und Orientierungsphase,&lt;br&#47;&gt;h) das empfohlene Lehrangebot in den ersten beiden Semestern,&lt;br&#47;&gt;i) die Vereinbarkeit von Studium und Beruf sowie&lt;br&#47;&gt;j) die Zahl der Studierenden im Studium, die durchschnittliche Studiendauer, die Studienerfolgsstatistik und die Beschäftigungsstatistik zu informieren sind, und&lt;p&#47;&gt;2. eine Einführung in die gute wissenschaftliche Praxis zu geben ist.</comment>
                    <performance xml:lang="de">Keine Leistungskontrolle</performance>
                    <literature xml:lang="de">&lt;a href=&#39;http:&#47;&#47;slw.univie.ac.at&#47;studieren&#47;studienorganisation&#47;&#39;&gt;http:&#47;&#47;slw.univie.ac.at&#47;studieren&#47;studienorganisation&#47;&lt;&#47;a&gt;&lt;br&#47;&gt;&lt;a href=&#39;https:&#47;&#47;www.youtube.com&#47;embed&#47;I_BC9JPKyfo&#39;&gt;https:&#47;&#47;www.youtube.com&#47;embed&#47;I_BC9JPKyfo&lt;&#47;a&gt;&lt;br&#47;&gt;&lt;a href=&#39;https:&#47;&#47;studieren.univie.ac.at&#47;barrierefrei-studieren&#47;&#39;&gt;https:&#47;&#47;studieren.univie.ac.at&#47;barrierefrei-studieren&#47;&lt;&#47;a&gt;&lt;br&#47;&gt;&lt;a href=&#39;https:&#47;&#47;international.univie.ac.at&#47;berichte-artikel-interviews&#47;veranstaltungen&#47;digitale-infoveranstaltung&#47;&#39;&gt;https:&#47;&#47;international.univie.ac.at&#47;berichte-artikel-interviews&#47;veranstaltungen&#47;digitale-infoveranstaltung&#47;&lt;&#47;a&gt;&lt;br&#47;&gt;&lt;a href=&#39;https:&#47;&#47;ctl.univie.ac.at&#47;services-zur-qualitaet-von-studien&#47;steop-mentoring&#47;informationen-fuer-studierende&#47;&#39;&gt;https:&#47;&#47;ctl.univie.ac.at&#47;services-zur-qualitaet-von-studien&#47;steop-mentoring&#47;informationen-fuer-studierende&#47;&lt;&#47;a&gt;</literature>
                    <examination xml:lang="de">n.a.</examination>
                    <preconditions xml:lang="de">n.a.</preconditions>
                </info>
                <labels>
                    <label>
                        <id xml:lang="de">OV</id>
                        <name xml:lang="de">Orientierungsveranstaltung</name>
                        <name xml:lang="en">Orientation course</name>
                    </label>
                </labels>
            </group>
        </groups>
        <offeredby id="8505">SPL 5 - Informatik und Wirtschaftsinformatik</offeredby>
    </course>
    ''');
    test(
        "When a Course object is created from a full tag, with 2 chapters and 1 group"
        "then all its fields should be non-null.", () {
      final obj = Course.fromXmlTag(fullTag);
      expect(obj.id, isNotNull, reason: 'id should not be null');
      expect(obj.when, isNotNull, reason: 'when should not be null');
      expect(obj.version, isNotNull, reason: 'version should not be null');
      expect(obj.longName, isNotNull, reason: 'longName should not be null');
      expect(obj.longName, NumberOfLanguages(equals(2)),
          reason: 'longName should should be available in 2 language(s)');
      expect(obj.courseType, isNotNull,
          reason: 'courseType should not be null');
      expect(obj.ects, isNotNull, reason: 'ects should not be null');
      expect(obj.ects, isNotNull, reason: 'ects should not be null');
      expect(obj.sws, isNotNull, reason: 'sws should not be null');
      expect(obj.immanent, isNotNull, reason: 'immanent should not be null');
      expect(obj.chapters, isNotNull, reason: 'chapters should not be null');
      expect(obj.chapters!.length, equals(2),
          reason: 'chapters should have a length of 2');
      expect(obj.groups, isNotNull, reason: 'groups should not be null');
      expect(obj.groups!.length, equals(1),
          reason: 'groups should have a length of 1');
      expect(obj.courseOfferee, isNotNull,
          reason: 'courseOfferee should not be null');
    });
  });
}
