
import 'package:base_template_project/screens/ble/ble_tech_control_screen.dart';
import 'package:base_template_project/screens/login_screen.dart';
import 'package:base_template_project/screens/settings/settings_screen.dart';
import 'package:base_template_project/utils/config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';

import '../configuration.dart';
import '../utils/i18n/i18n.dart';
import '../widgets/rounded_button.dart';

class HomeScreen extends StatefulWidget with Log4Dart {
  static const String id = 'home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final localizations = context.watch<KLocalizations>();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 7.0),
          child: Text(
            kAppTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Pacifico',
                  fontSize: 26,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, SettingsScreen.id);
              },
              icon: const Icon(
                Icons.settings,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'logo',
              child: SizedBox(
                height: 70.0,
                child: Image.asset('assets/images/logo.png'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                kAppTitle,
                style: Theme.of(context).textTheme.headline1!.copyWith(
                      fontFamily: 'Pacifico',
                      fontSize: 38.0,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                localizations.translate(kAppSubtitle),
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontFamily: 'Pacifico',
                      fontSize: 18.0,
                    ),
              ),
            ),
            const SizedBox(height: 35.0),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${localizations.translate('Language')}: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  LocalizedText(
                    '${I18N.getCurrentLanguage()?.name}-Own-Lang',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${localizations.translate('Dark Theme')}: ',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    localizations.translate('${context.watch<AppConfig>().getDarkModeEnabled()}'),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
            RoundedButton(
              label: localizations.translate('Go to Login'),
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                // Navigator.pushReplacementNamed(context, HomeScreen.id);
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              label: localizations.translate('BLE Tech Screen'),
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                // Navigator.pushReplacementNamed(context, HomeScreen.id);
                Navigator.pushNamed(context, BLETechControlScreen.id);
              },
            ),
            RoundedButton(
              label: localizations.translate('Gemma Hack Screen'),
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                // Navigator.pushReplacementNamed(context, HomeScreen.id);
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   tooltip: 'Increment',
      //   onPressed: () {
      //     // debugDumpApp();
      //     // throw Exception('ninanu');
      //     print(Zone.current);
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
