import 'dart:ui';

extension LocaleWithComboKey on Locale {
  String comboKey() {
    return '${languageCode}_${countryCode!}';
  }
}
