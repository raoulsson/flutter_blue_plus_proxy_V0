import 'dart:collection';

import 'package:base_template_project/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import '../../configuration.dart';
import 'language.dart';
import 'locale_extension.dart';

class I18N with Log4Dart {
  static I18N? _instance;
  final Map<String, Language> _languagesMap;
  String _selectedLanguageKey = AppConfig.instance.getSelectedLanguageKey();

  I18N._(this._languagesMap);

  static bool init(Map<String, Language> languageMap) {
    assert(_instance == null);
    _instance = I18N._(languageMap);
    return true;
  }

  /// Returns singleton with values that can change over runtime
  static I18N get instance {
    assert(_instance != null);
    return _instance!;
  }

  void _set(String key) {
    if (_languagesMap.containsKey(key)) {
      _selectedLanguageKey = key;
    } else {
      throw Exception('No such language for key: $key');
    }
  }

  Language? _get(String key) {
    if (_languagesMap.containsKey(key)) {
      return _languagesMap[key];
    }
    throw Exception('Language key $key not found');
  }

  static UnmodifiableListView<Language> getSupportedLanguages() {
    return UnmodifiableListView(_instance!._languagesMap.values);
  }

  static Language? getCurrentLanguage() {
    return _instance!._get(_instance!._selectedLanguageKey);
  }

  static void setCurrentLanguageByLocaleKey(String key) {
    _instance!._set(key);
  }

  static Locale getCurrentLocale() {
    final List<Locale> supportedLocales = getSupportedLocales();
    final String selectedLanguageKey = AppConfig.instance.getSelectedLanguageKey();
    return supportedLocales.firstWhere((loc) => loc.comboKey() == selectedLanguageKey);
  }

  static List<Locale> getSupportedLocales() {
    List<Locale> supportedLocales = [];
    for (var v in kSupportedLanguages) {
      supportedLocales.add(v.locale);
    }
    return UnmodifiableListView(supportedLocales);
  }
}
