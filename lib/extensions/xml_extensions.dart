import 'package:we_find/model/I18NString.dart';
import 'package:xml/xml.dart';

/// Returns the boolean value of the specified string
/// if it is either "true" or "false"
bool? stringToBool(String? string) =>
    (string != null && (string == "true" || string == "false"))
        ? string == "true"
        : null;

extension Parser on XmlElement {
  /// checks whether this XmlElement has an attribute xml:lang="lang"
  bool hasLanguage(Lang lang) =>
      getAttribute('xml:lang') == lang.toString().split('.').last.toLowerCase();

  /// Returns an I18NString from the direct descendant's text
  /// that match a constant of the Lang enum
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

  /// Returns a DateTime from the attribute of this tag with attributeName
  /// if it is possible to parse its value
  DateTime? attrToDateTime(String attributeName) {
    return DateTime.tryParse(getAttribute(attributeName) ?? "");
  }

  /// Returns the boolean value of the attribute of this tag with attributeName
  /// if it is either "true" or "false"
  bool? attrToBool(String attributeName) =>
      stringToBool(getAttribute(attributeName));

  bool? textToBool() => stringToBool(text);

  int? textToInt() => int.tryParse(text);

  double? textToDouble() => double.tryParse(text);

  /// Creates a list of elements mapped to the direct descendants
  /// of this tag with the specified name
  List<T> mapDescendants<T>(String name, T Function(XmlElement) mapper) {
    return findElements(name).map(mapper).toList(growable: false);
  }

  /// Applies the mapper function to the descendant of this tag with name
  /// or returns null if no such element is found
  T? mapDescendant<T>(String name, T Function(XmlElement) mapper) {
    final descendant = getElement(name);
    return descendant != null ? mapper(descendant) : null;
  }
}
