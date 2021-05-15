import 'package:we_find/model/I18NString.dart';
import 'package:xml/xml.dart';

/// Returns the parsed [bool] from the specified [String]
/// or [null] if the provided [String] is [null],
/// or if it is not one of the values: [{'true', 'false'}].
bool? stringToBool(String? string) =>
    (string != null && (string == "true" || string == "false"))
        ? string == "true"
        : null;

/// Custom methods to abstract away recurring XML-parsing tasks.
extension Parser on XmlElement {
  /// checks whether this tag has an attribute xml:lang='$lang'.
  bool hasLanguage(Lang lang) =>
      getAttribute('xml:lang') == lang.toString().split('.').last.toLowerCase();

  /// Returns an [I18NString] from the direct descendant's text
  /// that match a constant of the [Lang] enum.
  I18NString? toI18NString(String name) {
    final map = new Map<Lang, String>();
    for (var element in findElements(name)) {
      for (var lang in Lang.values) {
        if (element.hasLanguage(lang)) {
          map.putIfAbsent(lang, () => element.text);
        }
      }
    }
    return map.isNotEmpty ? new I18NString(map) : null;
  }

  /// Returns the parsed [DateTime] from the value of the specified attribute
  /// or [null] if this tag has no attribute called [name]
  /// or [null] if the value cannot be parsed into a [DateTime] object.
  DateTime? attrToDateTime(String name) {
    return DateTime.tryParse(getAttribute(name) ?? "");
  }

  /// Returns the parsed [bool] from the value of the specified attribute
  /// or [null] if this tag has no attribute called [name]
  /// or [null] if the value is not one of the values: [{'true', 'false'}].
  bool? attrToBool(String name) => stringToBool(getAttribute(name));

  /// Returns the parsed [bool] from the text value of this tag
  /// or [null] if the value is not one of the values: [{'true', 'false'}].
  bool? textToBool() => stringToBool(text);

  /// Returns the parsed [int] from the value of the specified attribute
  /// or [null] if this tag has no attribute called [name]
  /// or [null] if the value cannot be parsed into an [int].
  int? attrToInt(String name) => int.tryParse(getAttribute(name) ?? "");

  /// Returns the parsed [int] from the text value of this tag
  /// or [null] if the value cannot be parsed into an [int].
  int? textToInt() => int.tryParse(text);

  /// Returns the parsed [double] from the text value of this tag
  /// or [null] if the value cannot be parsed into a [double].
  double? textToDouble() => double.tryParse(text);

  /// Applies the [mapper] function to all descendants of this tag with [name]
  /// and returns a list of these items.
  List<T> mapDescendants<T>(String name, T Function(XmlElement) mapper) {
    return findElements(name).map(mapper).toList(growable: false);
  }

  /// Applies the [mapper] function to the first descendant of this tag with [name]
  /// or returns [null] if no descendant with [name] is found.
  T? mapDescendant<T>(String name, T Function(XmlElement) mapper) {
    final descendant = getElement(name);
    return descendant != null ? mapper(descendant) : null;
  }

  /// Applies the [mapper] function to the attribute value of this tag with [name]
  /// or returns [null] if no attribute with [name] is found.
  T? mapAttribute<T>(String name, T Function(String) mapper) {
    final attr = getAttribute(name);
    return attr != null ? mapper(attr) : null;
  }
}
