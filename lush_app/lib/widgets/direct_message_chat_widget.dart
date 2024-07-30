import 'package:flutter/material.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';
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
  final Function(Message message)? onReply;

  @override
  Widget build(BuildContext context) {
    final List<Message> messages =
        []; //snapshot.data!.reversed.toList(); //TODO: Implementare loading dati

    return Flexible(
      child: ListView.builder(
        controller: scrollController,
        itemCount: messages.length,
        reverse: true,
        itemBuilder: (context, index) =>
            _buildMessageItem(context, messages, index),
      ),
    );
  }

  Widget _buildMessageItem(
      BuildContext context, List<Message> messages, int index) {
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
          isMe: message.senderId == '', //TODO: Implementare current user id
          onReplyTap: (_) {}, // (replyMessageId) =>
          //_scrollToMessage(replyMessageId, messages),
          onLongPressActions: const [] //_buildLongPressActions(context, message),
          ),
    );
  }

  /*List<ActionItemDirectOverlayWidget> _buildLongPressActions(
      BuildContext context, Message message) {
    final String currentUserId = ''; //TODO: Implementare current user id
    return [
      ActionItemDirectOverlayWidget(
        viewModel: ActionOverlayMenuItemViewModel(
          label: message.isFavoriteForUser(currentUserId)
              ? 'Rimuovi dai preferiti'
              : 'Aggiungi ai preferiti',
          icon: message.isFavoriteForUser(currentUserId)
              ? Icons.bookmark
              : Icons.bookmark_border,
        ),
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

  void _scrollToMessage(String messageId, List<MessageModelss> messages) {
    final index = messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      scrollController.animateTo(
        index * 100.0, // Assumendo un'altezza fissa per ogni messaggio
        duration: scrollAnimationDuration,
        curve: Curves.easeInOut,
      );
    }
  }*/
}
