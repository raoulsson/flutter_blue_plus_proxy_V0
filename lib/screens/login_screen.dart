import 'package:base_template_project/configuration.dart';
import 'package:base_template_project/screens/settings/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/rounded_button.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Log4Dart {
  late String email = 'jack@bauer.com';
  late String password = 'gogogo';
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

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
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                controller: TextEditingController(text: 'jack@bauer.com'),
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kEmailInputDecoration.copyWith(hintText: '${localizations.translate('Enter Email')}...'),
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: TextEditingController(text: 'gogogo'),
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kEmailInputDecoration.copyWith(hintText: '${localizations.translate('Enter Password')}...'),
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                label: localizations.translate('Log In'),
                color: Theme.of(context).colorScheme.secondary,
                onTap: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final returningUser = await _auth.signInWithEmailAndPassword(email: email, password: password);
                    // print(returningUser);
                    Navigator.pushNamed(context, ChatScreen.id);

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
