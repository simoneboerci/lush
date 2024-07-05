import 'package:flutter/material.dart';

import 'package:lush_app/models/direct_message.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/widgets/message_bubble_widget.dart';

class DirectMessageChatWidget extends StatelessWidget {
  const DirectMessageChatWidget({
    super.key,
    //required this.chat,
  });

  //final ChatModel chat;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder<List<DirectMessage>>(
        stream: FirebaseHelper.getMessagesFromChat('iwugfouqwhfouqwhdoqdq'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Errr: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No messages yet.'),
            );
          }

          final messages = snapshot.data!;

          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              String? previousMessageSender = index < messages.length - 1
                  ? messages[index + 1].senderId
                  : null;

              EdgeInsets padding = message.senderId != previousMessageSender
                  ? const EdgeInsets.only(bottom: 8.0)
                  : EdgeInsets.zero;

              return Padding(
                padding: padding,
                child: MessageBubbleWidget(
                    message: message, isMe: message.senderId == 'currentUserId'
                    //FirebaseHelper.getCurrentUserUid,
                    ),
              );
            },
          );
        },
      ),
    );
  }
}
