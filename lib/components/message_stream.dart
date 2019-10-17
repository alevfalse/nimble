import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nimble/constants.dart';

import 'message_bubble.dart';

/*
This is the MessagesStream widget. Using the StreamBuilder class, this widget listens
for new data (messages) from the database and then builds the ListView which is
composed of a list of MessageBubble widgets.
*/
class MessagesStream extends StatelessWidget {
  final Firestore firestore;
  final FirebaseUser loggedInUser;

  const MessagesStream({@required this.firestore, @required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').orderBy('timestamp').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: kPrimaryLightColor,
            ),
          );
        }

        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];

          final messageWidget = MessageBubble(
            text: messageText ?? '<blank>',
            sender: messageSender,
            isMe: messageSender == loggedInUser.email,
          );
          messageBubbles.add(messageWidget);
        }

        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
            reverse: true,
          ),
        );
      },
    );
  }
}
