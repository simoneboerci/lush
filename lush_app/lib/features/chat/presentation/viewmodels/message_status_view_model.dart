import 'package:flutter/material.dart';
import 'package:lush_app/core/constants/colors.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

enum MessageStatusDisplay { none, sent, delivered, read }

class MessageStatusViewModel {
  final MessageStatusDisplay status;
  final Color sentIconColor;
  final Color deliveredIconColor;
  final Color readIconColor;
  final IconData sentIcon;
  final IconData deliveredIcon;
  final IconData readIcon;
  final double iconSize;

  const MessageStatusViewModel({
    required this.status,
    this.sentIconColor = Colors.white,
    this.deliveredIconColor = Colors.white,
    this.readIconColor = cSecondaryColor,
    this.sentIcon = Icons.check,
    this.deliveredIcon = Icons.done_all,
    this.readIcon = Icons.done_all,
    this.iconSize = 16.0,
  });

  factory MessageStatusViewModel.fromMessage(
      Message message, String currentUserId) {
    if (message.senderId != currentUserId) {
      return const MessageStatusViewModel(status: MessageStatusDisplay.none);
    }

    return MessageStatusViewModel(
        status: switch (message.status) {
      MessageStatus.sent => MessageStatusDisplay.sent,
      MessageStatus.delivered => MessageStatusDisplay.delivered,
      MessageStatus.read => MessageStatusDisplay.read,
    });
  }

  IconData get icon => switch (status) {
        MessageStatusDisplay.none => Icons.error,
        MessageStatusDisplay.sent => sentIcon,
        MessageStatusDisplay.delivered => deliveredIcon,
        MessageStatusDisplay.read => readIcon,
      };

  Color get color => switch (status) {
        MessageStatusDisplay.none => Colors.transparent,
        MessageStatusDisplay.sent => sentIconColor,
        MessageStatusDisplay.delivered => deliveredIconColor,
        MessageStatusDisplay.read => readIconColor,
      };
}
