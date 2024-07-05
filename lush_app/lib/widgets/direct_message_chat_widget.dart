import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lush_app/models/direct_message.dart';

import 'package:lush_app/widgets/message_bubble_widget.dart';

class DirectMessageChatWidget extends StatelessWidget {
  DirectMessageChatWidget({super.key});

  final List<DirectMessage> messages = [
    DirectMessage(text: 'Quando vuoi', sender: '', timestamp: Timestamp.now()),
    DirectMessage(
        text: 'Domani per che ora sei libera?',
        sender: 'Me',
        timestamp: Timestamp.now()),
    DirectMessage(
        text:
            'Domani possiamo fare verso sera. Esco dal lavoro alle 18:00, va bene?',
        sender: '',
        timestamp: Timestamp.now()),
    DirectMessage(
        text: 'Altrimenti mercoledì alle 14:00, dimmi tu',
        sender: '',
        timestamp: Timestamp.now()),
    DirectMessage(
        text: 'Ottimo per domani alle 18:00',
        sender: 'Me',
        timestamp: Timestamp.now()),
    DirectMessage(text: 'Perfetto :)', sender: '', timestamp: Timestamp.now()),
    DirectMessage(
        text: 'Un piccolo regalo per te',
        sender: '',
        timestamp: Timestamp.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[messages.length - 1 - index];
          String previousMessageSender = 'None';
          try {
            previousMessageSender =
                messages[messages.length - 1 - index - 1].sender;
          } catch (_) {}
          EdgeInsets padding = message.sender != previousMessageSender
              ? const EdgeInsets.only(bottom: 8.0)
              : EdgeInsets.zero;
          return Padding(
            padding: padding,
            child: MessageBubbleWidget(
                message: message, isMe: message.sender == 'Me'),
          );
        },
      ),
    );
  }
}
