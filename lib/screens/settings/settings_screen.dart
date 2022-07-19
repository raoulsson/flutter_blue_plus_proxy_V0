import 'dart:io';

import 'package:base_template_project/utils/config/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../utils/i18n/i18n.dart';
import 'languages_screen.dart';

class SettingsScreen extends StatefulWidget with Log4Dart {
  static const String id = 'settings/settings_screen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkModeEnabled = false;
  bool notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: LocalizedText(
          'Settings',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: 'Pacifico',
                fontSize: 26,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      body: buildSettingsList(),
    );
  }

  Widget buildSettingsList() {
    return SettingsList(
      sections: [
        SettingsSection(
          title: const LocalizedText('Common'),
          tiles: [
            SettingsTile(
              title: const LocalizedText('Language'),
              trailing: LocalizedText('${I18N.getCurrentLanguage()?.name}'),
              leading: const Icon(Icons.language),
              onPressed: (context) {
                Navigator.of(context).pushNamed(SettingsLanguagesScreen.id);
              },
            ),
            SettingsTile.switchTile(
              initialValue: context.read<AppConfig>().getDarkModeEnabled(),
              title: const LocalizedText('Dark Mode'),
              leading: const Icon(Icons.dark_mode),
              onToggle: (bool value) {
                setState(() {
                  darkModeEnabled = value;
                  context.read<AppConfig>().setDarkModeEnabled(context, darkModeEnabled);
                });
              },
            ),
          ],
        ),
        SettingsSection(
          title: const LocalizedText('Account'),
          tiles: [
            SettingsTile(
              title: const LocalizedText('Reset All Settings'),
              leading: const Icon(Icons.clear_all),
              onPressed: (val) {
                showResetModalDialog(context);
              },
            ),
          ],
        ),
        SettingsSection(
          title: const LocalizedText('Misc'),
          tiles: [
            SettingsTile(title: const LocalizedText('Terms of Service'), leading: const Icon(Icons.description)),
            SettingsTile(title: const LocalizedText('License'), leading: const Icon(Icons.collections_bookmark)),
          ],
        ),
      ],
    );
  }

  void showResetModalDialog(BuildContext context) {
    if (Platform.isIOS) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: const LocalizedText('Reset App Preferences?'),
            actions: [
              CupertinoDialogAction(
                child: const LocalizedText(
                  'Cancel',
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              CupertinoDialogAction(
                child: const LocalizedText(
                  'Reset',
                ),
                onPressed: () {
                  context.read<AppConfig>().resetAppPreferencesToFactoryDefaults(context);
                  Navigator.pop(context);
                },
              ),
            ],
            content: const LocalizedText('This will delete all your app preferences and restore it with the factory defaults'),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const LocalizedText('Reset App Preferences?'),
            actionsOverflowButtonSpacing: 20,
            actions: [
              ElevatedButton(
                child: const LocalizedText(
                  'Cancel',
                ),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: const LocalizedText(
                  'Reset',
                ),
                onPressed: () {
                  context.read<AppConfig>().resetAppPreferencesToFactoryDefaults(context);
                  Navigator.pop(context);
                },
              ),
            ],
            content: const LocalizedText('This will delete all your app preferences and restore it with the factory defaults'),
          );
        },
      );
    }
  }
}
