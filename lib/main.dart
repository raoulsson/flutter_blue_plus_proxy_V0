import 'dart:async';

import 'package:base_template_project/configuration.dart';
import 'package:base_template_project/screens/ble/device_screen.dart';
import 'package:base_template_project/screens/ble/ble_tech_control_screen.dart';
import 'package:base_template_project/screens/chat_screen.dart';
import 'package:base_template_project/screens/home_screen.dart';
import 'package:base_template_project/screens/loading_screen.dart';
import 'package:base_template_project/screens/login_screen.dart';
import 'package:base_template_project/screens/registration_screen.dart';
import 'package:base_template_project/screens/settings/languages_screen.dart';
import 'package:base_template_project/screens/settings/settings_screen.dart';
import 'package:base_template_project/utils/config/app_config.dart';
import 'package:base_template_project/utils/i18n/klocalizations_proxy.dart';
import 'package:base_template_project/utils/misc/app_error_handler.dart';
import 'package:base_template_project/utils/misc/environment_util.dart';
import 'package:base_template_project/utils/theme/theme_loader.dart';
import 'package:base_template_project/utils/theme/theme_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';

import 'ble/flutter_blue_plus_proxy.dart';
import 'firebase_options.dart';
import 'utils/i18n/i18n.dart';

void main() async {
  await Logger.init(kLog4DartConfig);
  final AppErrorHandler appErrorHandler = AppErrorHandler();

  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await appErrorHandler.init();
    FlutterError.onError = (FlutterErrorDetails flutterErrorDetails) {
      FlutterError.presentError(flutterErrorDetails);
      appErrorHandler.onFlutterError(flutterErrorDetails: flutterErrorDetails);
    };

    await AppConfig.init();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    final Map<String, ThemeData> themes = {};
    //themes[ThemeMode.system.name] = await ThemeLoader.loadFlexColorScheme(ThemeMode.system);
    themes[ThemeMode.light.name] = await ThemeLoader.loadFlexColorScheme(ThemeMode.light);
    themes[ThemeMode.dark.name] = await ThemeLoader.loadFlexColorScheme(ThemeMode.dark);
    final bool darkModeEnabled = AppConfig.instance.getDarkModeEnabled();

    I18N.init(AppConfig.instance.getSupportedLanguages());

    bool onDevice = await EnvironmentUtil.runningOnPhysicalDevice();
    FlutterBluePlusProxy.init(onDevice: onDevice); //printDataAsMockDefs: true);
    FlutterBluePlusProxy.instance.setLogLevel(LogLevel.emergency);

    var multiProvider = MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) => ThemeNotifier(darkModeEnabled, themes),
        ),
        ChangeNotifierProvider<AppConfig>(
          create: (_) => AppConfig.instance,
        ),
        ChangeNotifierProvider<KLocalizations>(
          create: (_) => KLocalizationsProxy(
            locale: I18N.getCurrentLocale(),
            defaultLocale: I18N.getCurrentLocale(),
            supportedLocales: I18N.getSupportedLocales(),
            localizationsAssetsPath: 'assets/translations',
            throwOnMissingTranslation: true,
          ),
        ),
      ],
      child: MainApp(),
    );
    runApp(multiProvider);
  }, (Object error, StackTrace stackTrace) {
    appErrorHandler.onError(error: error, stackTrace: stackTrace);
    //exit(1);
  }, zoneValues: {
    'logging.device-hash': ['DEX203'],
    'logging.session-hash': ['U9480'],
  });
}

class MainApp extends StatelessWidget with Log4Dart {
  MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = context.watch<KLocalizations>();
    final themeNotifier = context.watch<ThemeNotifier>();

    return MaterialApp(
      locale: localizations.locale,
      supportedLocales: localizations.supportedLocales,
      localizationsDelegates: [
        localizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      initialRoute: LoadingScreen.id,
      routes: {
        LoadingScreen.id: (BuildContext context) => const LoadingScreen(),
        HomeScreen.id: (BuildContext context) => const HomeScreen(),
        BLETechControlScreen.id: (BuildContext context) => BLETechControlScreen(),
        SettingsScreen.id: (BuildContext context) => const SettingsScreen(),
        SettingsLanguagesScreen.id: (BuildContext context) => const SettingsLanguagesScreen(),
        LoginScreen.id: (BuildContext context) => const LoginScreen(),
        RegistrationScreen.id: (BuildContext context) => const RegistrationScreen(),
        ChatScreen.id: (BuildContext context) => const ChatScreen(),
        DeviceScreen.id: (BuildContext context) => DeviceScreen(),
      },
      theme: themeNotifier.getTheme(), //themeNotifier.getTheme(),
    );
  }
}
