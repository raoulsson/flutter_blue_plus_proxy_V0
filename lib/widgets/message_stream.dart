import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? thisSender;

  MessageStream({Key? key, required this.thisSender}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>?>?>(
        stream: _firestore.collection('messages').orderBy('timestamp').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>?>? qs = snapshot.data;
            final List<QueryDocumentSnapshot<Map<String, dynamic>?>>? messages = qs?.docs.reversed.toList();
            List<MessageBubble> messageBubbles = [];

            for (QueryDocumentSnapshot<Map<String, dynamic>?>? message in messages!) {
              Map<String, dynamic>? data = message?.data();
              String text = data!['text'];
              String sender = data['sender'];
              // print('sender: $sender');
              // print('thisSender: $thisSender');
              messageBubbles.add(MessageBubble(
                text: text,
                sender: sender,
                isMe: thisSender == sender,
              ));
            }
            return Expanded(
              child: ListView(
                reverse: true,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 20.0,
                ),
                children: messageBubbles,
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
