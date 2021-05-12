/// Custom class to represent a String that might be available
/// in multiple locales/languages
class I18NString {
  static const Lang fallback = Lang.DE;
  final Map<Lang, String> _map;

  I18NString(this._map);

  /// Returns the string corresponding to the supplied `lang`.
  /// If no match is found for `lang` the fallback language will be used
  /// to return a value. If the fallback language also does not exist,
  /// then the empty string is returned
  String get(Lang lang) => _map[lang] ?? _map[fallback] ?? '';
}

enum Lang { DE, EN }
