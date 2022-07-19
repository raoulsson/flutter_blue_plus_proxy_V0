import 'dart:ui';

import 'utils/i18n/language.dart';

const kLogoFile = 'assets/images/logo.png';
const kAppTitle = 'Bla App';
const kAppSubtitle = 'Pride in wood';
const kSimulatedLoadingTime = 500;
List<Language> kSupportedLanguages = [
  Language(name: 'German', locale: const Locale('de', 'CH')),
  Language(name: 'English', locale: const Locale('en', 'US')),
  Language(name: 'Spanish', locale: const Locale('es', 'ES')),
];
const kWriteFixedLocalizationToDisk = true;
const kForceStoredPreferencesDeletion = false;

// const kDarkModeEnabled = true;
const kDarkModeEnabled = false;
const kDefaultLanguageKey = 'de_CH'; // combo of locale params, eg. de and CH become de_CH

/// Sentry settings
const kSentryEnabled = true;
const kSentryLogErrors = true;
const kSentryLogFlutterErrors = true;
const kSentryDsn = 'asdf';

/// Log4Dart

const kLog4DartConfig = {
  'appenders': [
    {
      'type': 'CONSOLE',
      'format': '%d%i%l%c %m %f',
      'level': 'DEBUG',
      'dateFormat': 'yyyy-MM-dd HH:mm:ss.SSS',
      'brackets': true,
      'mode': 'stdout'
    },
  ]
};
