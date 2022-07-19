import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:klocalizations_flutter/klocalizations_flutter.dart';
import 'package:log_4_dart_2/log_4_dart_2.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

import '../configuration.dart';
import '../constants.dart';
import '../widgets/message_stream.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with Log4Dart {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  String messageText = '';
  bool showSpinner = false;
  final TextEditingController messageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      setState(() {
        loggedInUser = user;
      });
      logDebug('Logged In User: ${loggedInUser?.email}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = context.watch<KLocalizations>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              tooltip: localizations.translate('Sign out'),
              onPressed: () {
                logDebug('Sign out user: ${_auth.currentUser?.email}');
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
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
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessageStream(thisSender: loggedInUser?.email),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration.copyWith(hintText: '${localizations.translate('Type your message here')}...'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        try {
                          if (messageText.trim() != '') {
                            _firestore.collection('messages').add(
                              {
                                'sender': loggedInUser?.email,
                                'text': messageText,
                                'timestamp': DateTime.now().toUtc().millisecondsSinceEpoch,
                              },
                            );
                            logDebug('message sent: $messageText');
                            setState(() {
                              messageText = '';
                            });
                            messageTextController.clear();
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: const LocalizedText(
                        'Send',
                        style: kSendButtonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
