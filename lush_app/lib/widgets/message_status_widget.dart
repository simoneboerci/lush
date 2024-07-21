import 'package:flutter/material.dart';

import 'package:lush_app/constants/colors.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/message_model.dart';

class MessageStatusWidget extends StatelessWidget {
  const MessageStatusWidget({
    super.key,
    required this.message,
    this.sentIconColor = Colors.white,
    this.deliveredIconColor = Colors.white,
    this.readIconColor = cSecondaryColor,
    this.sentIcon = Icons.check,
    this.deliveredIcon = Icons.done_all,
    this.readIcon = Icons.done_all,
    this.iconSize = 16.0,
  });

  final MessageModel message;
  final IconData? sentIcon;
  final IconData? deliveredIcon;
  final IconData? readIcon;
  final Color? sentIconColor;
  final Color? deliveredIconColor;
  final Color? readIconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    if (message.senderId != FirebaseHelper().userHelper.currentUserUid) {
      return Container();
    } else {
      switch (message.status) {
        case MessageStatus.sent:
          return Icon(
            sentIcon,
            color: sentIconColor,
            size: iconSize,
          ); // Spunta singola se non è stato consegnato
        case MessageStatus.delivered:
          return Icon(
            deliveredIcon,
            color: deliveredIconColor,
            size: iconSize,
          ); // Spunta doppia se consegnato ma non letto
        case MessageStatus.read:
          return Icon(
            readIcon,
            color: readIconColor,
            size: iconSize,
          ); // Spunta doppia colorata se letto
        default:
          return Container(); // Default case
      }
    }
  }
}
