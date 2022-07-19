import '../../configuration.dart';

/// https://docs.flutter.dev/development/data-and-backend/json#serializing-json-inside-model-classes
class AppPreferences {
  static const storageKey = 'app_preferences_storage_key';
  bool darkModeEnabled = kDarkModeEnabled;
  String selectedLanguageKey = kDefaultLanguageKey;

  AppPreferences.fromFactoryConfig() {
    darkModeEnabled = kDarkModeEnabled;
    selectedLanguageKey = kDefaultLanguageKey;
  }

  AppPreferences(
    this.darkModeEnabled,
    this.selectedLanguageKey,
  );

  AppPreferences.fromJson(Map<String, dynamic> json)
      : darkModeEnabled = json['darkModeEnabled'],
        selectedLanguageKey = json['selectedLanguageKey'];

  Map<String, dynamic> toJson() => {
        'darkModeEnabled': darkModeEnabled,
        'selectedLanguageKey': selectedLanguageKey,
      };

  @override
  String toString() {
    return 'AppPreferences{darkModeEnabled: $darkModeEnabled, selectedLanguageKey: $selectedLanguageKey}';
  }
}
