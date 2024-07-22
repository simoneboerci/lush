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
      return const SizedBox.shrink();
    }

    return switch (message.status) {
      MessageStatus.sent => Icon(
          sentIcon,
          color: sentIconColor,
          size: iconSize,
        ),
      MessageStatus.delivered => Icon(
          deliveredIcon,
          color: deliveredIconColor,
          size: iconSize,
        ),
      MessageStatus.read => Icon(
          readIcon,
          color: readIconColor,
          size: iconSize,
        ),
    };
  }
}
