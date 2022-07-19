import 'dart:ui';

import 'locale_extension.dart';

class Language {
  final String key;
  final String name;
  final Locale locale;

  const Language._(this.key, this.name, this.locale);

  factory Language({required String name, required Locale locale}) {
    return Language._(locale.comboKey(), name, locale);
  }

  @override
  String toString() {
    return 'Language{key: $key, name: $name, locale: $locale}';
  }
}
