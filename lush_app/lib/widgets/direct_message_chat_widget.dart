import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/services/chat_provider.dart';
import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/message_model.dart';

import 'package:lush_app/widgets/action_item_direct_overlay_widget.dart';
import 'package:lush_app/widgets/message_bubble_widget.dart';

class DirectMessageChatWidget extends StatelessWidget {
  const DirectMessageChatWidget({
    super.key,
    required this.scrollController,
    this.scrollAnimationDuration = const Duration(milliseconds: 300),
    this.onReply,
  });

  final ScrollController scrollController;
  final Duration scrollAnimationDuration;
  final Function(MessageModel message)? onReply;

  @override
  Widget build(BuildContext context) {
    final ChatModel chat =
        Provider.of<ChatProvider>(context, listen: false).chat!;

    return Flexible(
      child: StreamBuilder<List<MessageModel>>(
        stream: FirebaseHelper().chatsHelper.getMessagesFromChat(chat.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No messages yet.'),
            );
          }

          final messages = snapshot.data!.reversed.toList();

          return ListView.builder(
            controller: scrollController,
            itemCount: messages.length,
            reverse: true,
            itemBuilder: (context, index) =>
                _buildMessageItem(context, messages, index),
          );
        },
      ),
    );
  }

  Widget _buildMessageItem(
      BuildContext context, List<MessageModel> messages, int index) {
    final message = messages[index];
    final String? previousMessageSender =
        index < messages.length - 1 ? messages[index + 1].senderId : null;

    final EdgeInsets padding = message.senderId != previousMessageSender
        ? const EdgeInsets.only(bottom: 8.0)
        : EdgeInsets.zero;

    return Padding(
      padding: padding,
      child: MessageBubbleWidget(
        message: message,
        isMe: message.senderId == FirebaseHelper().userHelper.currentUserUid,
        onReplyTap: (replyMessageId) =>
            _scrollToMessage(replyMessageId, messages),
        onLongPressActions: _buildLongPressActions(context, message),
      ),
    );
  }

  List<ActionItemDirectOverlayWidget> _buildLongPressActions(
      BuildContext context, MessageModel message) {
    final String currentUserId = FirebaseHelper().userHelper.currentUserUid!;
    return [
      ActionItemDirectOverlayWidget(
        label: message.isFavoriteForUser(currentUserId)
            ? 'Rimuovi dai preferiti'
            : 'Aggiungi ai preferiti',
        icon: message.isFavoriteForUser(currentUserId)
            ? Icons.bookmark
            : Icons.bookmark_border,
        onTap: () async {
          print('ON TAPPP');
          try {
            await Provider.of<ChatProvider>(context, listen: false)
                .toggleFavoriteMessage(message.id)
                .then((_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(message.isFavoriteForUser(currentUserId)
                        ? 'Messaggio rimosso dai preferiti'
                        : 'Messaggio aggiunto ai preferiti')),
              );
            });
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Errore nell\'aggiornare i preferiti')),
            );
          }
        },
      ),
      ActionItemDirectOverlayWidget(
        label: 'Rispondi',
        icon: Icons.replay,
        onTap: () {
          if (onReply != null) {
            onReply!(message);
          }
        },
      ),
      ActionItemDirectOverlayWidget(
        label: 'Copia',
        icon: Icons.content_copy,
        onTap: () async {
          await Clipboard.setData(ClipboardData(text: message.text)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Messaggio copiato negli appunti!')),
            );
          });
        },
      ),
      ActionItemDirectOverlayWidget(
        label: 'Fissa',
        icon: Icons.push_pin_outlined,
        onTap: () {},
      ),
      ActionItemDirectOverlayWidget(
        label: 'Segnala',
        icon: Icons.flag_outlined,
        onTap: () {},
      ),
      ActionItemDirectOverlayWidget(
        label: 'Elimina',
        icon: Icons.delete_outlined,
        iconColor: cPrimaryColor,
        textColor: cPrimaryColor,
        onTap: () {},
        addDivider: false,
      ),
    ];
  }

  void _scrollToMessage(String messageId, List<MessageModel> messages) {
    final index = messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      scrollController.animateTo(
        index * 100.0, // Assumendo un'altezza fissa per ogni messaggio
        duration: scrollAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }
}
