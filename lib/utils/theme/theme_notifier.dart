import 'package:flutter/material.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

class ThemeNotifier with ChangeNotifier, Log4Dart {
  late final Map<String, ThemeData> _themes;

  ThemeMode? _currentThemeMode;
  ThemeData? _currentTheme;

  ThemeNotifier(bool darkModeEnabled, Map<String, ThemeData> themes) {
    _themes = themes;
    _setCurrent(darkModeEnabled);
  }

  void reset(bool darkModeEnabled) {
    _setCurrent(darkModeEnabled);
    notifyListeners();
  }

  void _setCurrent(bool darkModeEnabled) {
    _currentThemeMode = darkModeEnabled ? ThemeMode.dark : ThemeMode.light;
    _currentTheme = _themes[_currentThemeMode?.name];
  }

  ThemeData? getTheme() {
    return _currentTheme;
  }

  setTheme(ThemeData? themeData) async {
    _currentTheme = themeData;
    notifyListeners();
  }

  void toggleDarkMode(BuildContext context) async {
    _currentThemeMode = _currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    setTheme(_themes[_currentThemeMode?.name]);
  }
}
