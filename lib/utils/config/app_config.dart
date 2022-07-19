import 'dart:collection';
import 'dart:convert';

import 'package:base_template_project/utils/storage/app_preferences.dart';
import 'package:base_template_project/utils/theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configuration.dart';
import '../i18n/i18n.dart';
import '../i18n/language.dart';
import '../i18n/locale_extension.dart';

class AppConfig extends ChangeNotifier with Log4Dart {
  /// Singleton: https://stackoverflow.com/a/59026238/132396
  static AppConfig? _instance;
  late SharedPreferences _sharedPreferences;
  late AppPreferences _prefs;
  late PackageInfo _packageInfo;

  // private constructor
  AppConfig._(SharedPreferences sp, PackageInfo pi) {
    _sharedPreferences = sp;
    _packageInfo = pi;
    if (kForceStoredPreferencesDeletion) {
      _sharedPreferences.clear();
    }
    _loadAppPreferences();
  }

  /// Called once from main.dart at very beginning to get the async loading out of the way downstream
  static Future<bool> init() async {
    assert(_instance == null);
    SharedPreferences sp = await SharedPreferences.getInstance();
    PackageInfo pi = await PackageInfo.fromPlatform();
    _instance = AppConfig._(sp, pi);

    return true;
  }

  /// Returns singleton with values that can change over runtime
  static AppConfig get instance {
    assert(_instance != null);
    return _instance!;
  }

  /// See https://stackoverflow.com/a/63413787/132396
  void _loadAppPreferences() {
    if (_sharedPreferences.containsKey(AppPreferences.storageKey)) {
      final String? appPrefsAsJson = _sharedPreferences.getString(AppPreferences.storageKey);
      Map<String, dynamic> appPrefsAsMap = jsonDecode(appPrefsAsJson!);
      _prefs = AppPreferences.fromJson(appPrefsAsMap);
      logDebug('Loaded app preferences from disk');
    } else {
      _prefs = AppPreferences.fromFactoryConfig();
      logDebug('Loaded app preferences from factory config');
    }
  }

  String getPreferencesAsJson() {
    return jsonEncode(_prefs.toJson());
  }

  void storeAppPreferences() {
    Map<String, dynamic> appPrefsAsMap = _prefs.toJson();
    String appPrefsAsJson = jsonEncode(appPrefsAsMap);
    _sharedPreferences.setString(AppPreferences.storageKey, appPrefsAsJson);
    logTrace(_prefs.toString());
  }

  void resetAppPreferencesToFactoryDefaults(BuildContext context) async {
    _sharedPreferences.clear();
    _loadAppPreferences();
    notifyListeners();

    // TODO: refactor so other notifiers get a reset method we can call
    I18N.setCurrentLanguageByLocaleKey(_prefs.selectedLanguageKey);
    context.read<ThemeNotifier>().reset(_prefs.darkModeEnabled);
    context.read<KLocalizations>().setLocale(I18N.getCurrentLocale());
  }

  String getVersionAndBuildInfo() {
    return '${_packageInfo.version} (build: ${_packageInfo.buildNumber})';
  }

  bool getDarkModeEnabled() {
    return _prefs.darkModeEnabled;
  }

  void setDarkModeEnabled(BuildContext context, bool darkModeEnabled) {
    _prefs.darkModeEnabled = darkModeEnabled;
    context.read<ThemeNotifier>().toggleDarkMode(context); // ThemeNotifier should be sync since startup in main.dart
    notifyListeners();
    storeAppPreferences();
  }

  String getSelectedLanguageKey() {
    return _prefs.selectedLanguageKey;
  }

  void setCurrentLanguageByLocaleKey(String languageKey) {
    I18N.setCurrentLanguageByLocaleKey(languageKey);
    _prefs.selectedLanguageKey = languageKey;
    notifyListeners();
    storeAppPreferences();
  }

  Map<String, Language> getSupportedLanguages() {
    Map<String, Language> languagesMap = {};
    for (Language v in kSupportedLanguages) {
      languagesMap[v.locale.comboKey()] = v;
    }
    return UnmodifiableMapView(languagesMap);
  }

  ThemeMode getThemeMode() {
    return ThemeMode.system;
  }
}
