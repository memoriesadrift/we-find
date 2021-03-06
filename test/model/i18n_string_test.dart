import 'package:test/test.dart';
import 'package:we_find/model/i18n_string.dart';

import 'model_matchers.dart';

void main() {
  test(
      "When a String is available in multiple languages, "
      "all the values should be returned.", () {
    final longNameDe = 'Programmierung 1';
    final longNameEn = 'Programming 1';
    final iString = new I18NString({Lang.DE: longNameDe, Lang.EN: longNameEn});
    expect(iString.get(Lang.DE), longNameDe);
    expect(iString.get(Lang.EN), longNameEn);
    expect(iString, NumberOfLanguages(equals(2)));
  });

  test(
      "When a String is available only in the fallback language, "
      "then when trying to access the representation in another language, "
      "then the value in the fallback language should be returned.", () {
    final longNameDe = 'Programmierung 1';
    final iString = new I18NString({Lang.DE: longNameDe});
    expect(iString.get(Lang.EN), longNameDe);
    expect(iString, NumberOfLanguages(equals(1)));
  });

  test(
      "When the dictionary is empty, then the returned value should be null "
      "for all languages.", () {
    final iString = new I18NString({});
    Lang.values.forEach((lang) => expect(iString.get(lang), null));
    expect(iString, NumberOfLanguages(equals(0)));
  });
}
