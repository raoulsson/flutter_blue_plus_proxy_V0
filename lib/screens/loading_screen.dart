import 'package:base_template_project/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:provider/provider.dart';

import '../configuration.dart';
import '../utils/config/app_config.dart';
import '../widgets/rounded_button.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const String id = 'loading_screen';

  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> with Log4Dart, SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation curveAnimation;
  late Animation colorAnimationWithTween;

  @override
  void initState() {
    super.initState();
    setupAnimationControllers();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.watch<KLocalizations>();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                height: 200.0,
                child: Image.asset(kLogoFile), //(curveAnimation.value * 80),
              ),
            ),
            const SizedBox(
              height: 28.0,
            ),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    fontSize: 55.0,
                    fontFamily: 'Pacifico',
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.onBackground.withOpacity(controller.value),
                  ),
              child: const Text(kAppTitle), // should probably not be translated
            ),
            const SizedBox(
              height: 28.0,
            ),
            Text(
              '${(controller.value * 100).toInt()}%',
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            RoundedButton(
              label: localizations.translate('Home Screen'),
              color: Theme.of(context).colorScheme.secondary,
              onTap: () {
                // Navigator.pushReplacementNamed(context, HomeScreen.id);
                // Navigator.pushNamed(context, HomeScreen.id);
                Navigator.pushNamed(context, HomeScreen.id);
              },
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              '${localizations.translate('Version')}: ${AppConfig.instance.getVersionAndBuildInfo()}\n',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void setupAnimationControllers() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: kSimulatedLoadingTime),
      lowerBound: 0.25,
      upperBound: 1.0,
    );

    colorAnimationWithTween = ColorTween(begin: Colors.black54, end: Colors.white).animate(controller);

    curveAnimation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.forward();
    //controller.reverse(from: 1.0);
    controller.addListener(() {
      setState(
          () {}); // controller value already changes, so we don't have to provide this in the body, we just trigger a rebuild
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose(); // note this is called after our own cleanup
  }
}
