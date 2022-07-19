import 'package:base_template_project/utils/config/app_config.dart';
import 'package:base_template_project/utils/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utils/i18n/language.dart';

class SettingsLanguagesScreen extends StatefulWidget {
  static const String id = 'settings/languages_screen';

  const SettingsLanguagesScreen({Key? key}) : super(key: key);

  @override
  _SettingsLanguagesScreenState createState() => _SettingsLanguagesScreenState();
}

class _SettingsLanguagesScreenState extends State<SettingsLanguagesScreen> with Log4Dart {
  late List<Language> configuredLanguages;
  late Language selectedLanguage;

  @override
  Widget build(BuildContext context) {
    configuredLanguages = I18N.getSupportedLanguages(); //, listen: false);
    selectedLanguage = I18N.getCurrentLanguage()!; //, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: LocalizedText(
            'Languages',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Pacifico',
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
      ),
      body: SettingsList(
        sections: [
          buildSettingsSection(selectedLanguage, configuredLanguages),
        ],
      ),
    );
  }

  SettingsSection buildSettingsSection(Language? currentLanguage, List<Language> languages) {
    List<SettingsTile> languageTiles = [];
    for (Language lang in languages) {
      if (lang == currentLanguage) {
        languageTiles.add(
          buildSettingsTile(selected: true, newLanguage: lang),
        );
      } else {
        languageTiles.add(
          buildSettingsTile(selected: false, newLanguage: lang),
        );
      }
    }
    return SettingsSection(tiles: languageTiles);
  }

  SettingsTile buildSettingsTile({required bool selected, required Language newLanguage}) {
    String langName = newLanguage.name;
    setState(() {
      langName = newLanguage.name;
    });
    return SettingsTile(
      title: LocalizedText(langName),
      trailing: trailingWidget(selected),
      onPressed: (BuildContext context) {
        setState(() {
          changeLanguage(newLanguage);
        });
      },
    );
  }

  Widget trailingWidget(bool selected) {
    return selected ? const Icon(Icons.check) : const Icon(null);
  }

  void changeLanguage(Language lang) {
    // TODO: get rid of context with riverpods and call from appconfig
    context.read<KLocalizations>().setLocale(lang.locale);
    context.read<AppConfig>().setCurrentLanguageByLocaleKey(lang.key);
  }
}
