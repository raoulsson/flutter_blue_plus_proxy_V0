import 'dart:convert';
import 'dart:ui';

import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';

import '../../configuration.dart';
import '../misc/illegal_key_exception.dart';
import '../storage/local_file_util.dart';

class KLocalizationsProxy extends KLocalizations with Log4Dart {
  final List<String> ignoreKeys = ['_config.textDirection'];
  KLocalizationsLoaderJson? loaderJson;
  final Map<String, dynamic> _tempInMemStrings = <String, dynamic>{};

  KLocalizationsProxy({
    required Locale locale,
    required Locale defaultLocale,
    required List<Locale> supportedLocales,
    String localizationsAssetsPath = 'assets/translations',
    bool throwOnMissingTranslation = false,
    KLocalizationsLoader? loader,
  }) : super(
          locale: locale,
          defaultLocale: defaultLocale,
          supportedLocales: supportedLocales,
          localizationsAssetsPath: localizationsAssetsPath,
          throwOnMissingTranslation: throwOnMissingTranslation,
          loader: loader,
        );

  /// Returns [TextDirection] for the current locale if specified, otherwise returns [TextDirection.ltr]
  @override
  TextDirection get textDirection {
    try {
      var localeConfigDirection = translate('_config.textDirection');
      switch (localeConfigDirection) {
        case 'rtl':
          return TextDirection.rtl;
        case 'ltr':
        default:
          return TextDirection.ltr;
      }
    } on MissingTranslationException {
      return TextDirection.ltr;
    }
  }

  @override
  void setLocale(Locale locale, {bool silent = false}) {
    super.setLocale(locale, silent: silent);
    super.load();
  }

  @override
  String translate(String key, {Map<String, dynamic>? params}) {
    if (key.contains('.') && !ignoreKeys.contains(key)) {
      throw InvalidKeyException(key);
    }
    try {
      return super.translate(key, params: params);
    } on MissingTranslationException {
      if (!ignoreKeys.contains(key)) {
        if (_tempInMemStrings.containsKey(key)) {
          return _tempInMemStrings[key];
        }
        // Store it in mem so we do not get the same message again per app-run
        _tempInMemStrings[key] = key;
        logWarn('Translation key not found: $key');
        logDebug('Add it to $localizationsAssetsPath/${locale.languageCode}.json: "$key":"$key",');
        if (kWriteFixedLocalizationToDisk) {
          addValueToFile(key, _tempInMemStrings);
        }
      }
      return key;
    }
  }

  Future<void> addValueToFile(String key, Map<String, dynamic> addedValuesMap) async {
    loaderJson ??= KLocalizationsLoaderJson(assetPath: localizationsAssetsPath);
    Map<String, dynamic>? translationMap = await loaderJson?.loadMapForLocale(locale);
    translationMap?[key] = key;
    translationMap?.addAll(addedValuesMap);
    String dataJsonEncoded = jsonEncode(translationMap);
    LocalFileUtil localFileUtil = LocalFileUtil();
    localFileUtil.writeStringToFile('${locale.languageCode}.json', dataJsonEncoded);
  }
}
