import 'package:flutter/material.dart';

import 'package:lush_app/constants/images.dart';

import 'package:lush_app/services/firebase_helper.dart';

import 'package:lush_app/models/chat_model.dart';
import 'package:lush_app/models/message_model.dart';

import 'package:lush_app/widgets/custom_text.dart';
import 'package:lush_app/widgets/message_status_widget.dart';
import 'package:lush_app/widgets/unread_message_bubble_widget.dart';

class ContactListTileWidget extends StatelessWidget {
  const ContactListTileWidget({
    super.key,
    required this.chat,
    required this.currentUserId,
    this.margin = EdgeInsets.zero,
    this.imageRadius,
    this.titleTextOverflow = TextOverflow.ellipsis,
    this.titleMaxLines = 1,
    this.titleTextColor = Colors.white,
    this.titleFontWeight = FontWeight.bold,
    this.subtitleTextOverflow = TextOverflow.ellipsis,
    this.subtitleTextColor = Colors.white,
    this.subtitleMaxLines = 1,
    this.subtitleFontSize = 14.0,
    this.trailingTextColor = Colors.white,
    this.trailingFontSize = 14.0,
    this.onTap,
  });

  final ChatModel chat;
  final String currentUserId;
  final EdgeInsets margin;
  final double? imageRadius;
  final TextOverflow? titleTextOverflow;
  final int? titleMaxLines;
  final Color? titleTextColor;
  final FontWeight? titleFontWeight;
  final TextOverflow? subtitleTextOverflow;
  final Color? subtitleTextColor;
  final int subtitleMaxLines;
  final double? subtitleFontSize;
  final Color? trailingTextColor;
  final double? trailingFontSize;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final lastMessage = chat.lastMessageId != null
        ? chat.getMessage(chat.lastMessageId!)
        : null;

    return Padding(
      padding: margin,
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          radius: imageRadius,
          backgroundImage: cLushTokenIcon,
        ),
        title: _buildTitle(),
        subtitle: lastMessage != null ? _buildSubtitle(lastMessage) : null,
        trailing: lastMessage != null ? _buildTrailing(lastMessage) : null,
      ),
    );
  }

  Widget _buildTitle() {
    return CustomText(
      text: chat.userIds.firstWhere((userId) => userId != currentUserId),
      color: titleTextColor,
      fontWeight: titleFontWeight,
      maxLines: titleMaxLines,
      textOverflow: titleTextOverflow,
    );
  }

  Widget _buildSubtitle(MessageModel lastMessage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MessageStatusWidget(message: lastMessage),
        const SizedBox(width: 4.0),
        Expanded(
            child: CustomText(
          text: lastMessage.text,
          color: subtitleTextColor,
          fontSize: subtitleFontSize,
          maxLines: subtitleMaxLines,
          textOverflow: subtitleTextOverflow,
        )),
      ],
    );
  }

  Widget _buildTrailing(MessageModel lastMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CustomText(
          text: _formatTimestamp(lastMessage.timestamp),
          color: trailingTextColor,
          fontSize: trailingFontSize,
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
