import 'package:flutter/material.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import 'defined_themes.dart';

class ThemeLoader with Log4Dart {
  static Future<ThemeData> loadFlexColorScheme(ThemeMode themeMode) async {
    if (themeMode == ThemeMode.system) {
      return ThemeData();
    }
    if (themeMode == ThemeMode.dark) {
      // return DefinedThemes.moneyDark;
      return DefinedThemes.blueWhaleDark;
    }
    // return DefinedThemes.moneyLight;
    return DefinedThemes.blueWhaleLight;
  }
}
