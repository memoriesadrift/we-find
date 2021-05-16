import 'package:flutter/material.dart';
import 'package:we_find/model/i18n_string.dart';

/// Provider that keeps track of the language set by the user
class LangProvider with ChangeNotifier {
  Lang _currentLang = Lang.DE;

  Lang get currentLang => _currentLang;

  /// Changes the language to [newLang] if it differs from the current language.
  void changeLang(Lang newLang) {
    // Trigger the listener notification only if a change actually occurred
    if (_currentLang != newLang) {
      _currentLang = newLang;
      notifyListeners();
    }
  }
}
