import 'package:flutter/material.dart';

import 'package:lush_app/features/chat/domain/entities/message.dart';
import 'package:lush_app/features/chat/presentation/viewmodels/message_status_view_model.dart';

class ContactListTileViewModel {
  final String contactName;
  final Message? lastMessage;
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
  final VoidCallback? onTap;

  String get lastMessageText => lastMessage?.text ?? '';
  String get lastMessageTime => _formatTimestamp(lastMessage?.timestamp);

  String? _currentUserId;

  ContactListTileViewModel({
    required this.contactName,
    this.lastMessage,
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

  bool get isLastMessageFromCurrentUser {
    return lastMessage?.senderId == _currentUserId;
  }

  MessageStatusViewModel? get messageStatusViewModel {
    if (lastMessage == null || _currentUserId == null) return null;
    return MessageStatusViewModel.fromMessage(lastMessage!, _currentUserId!);
  }

  String _formatTimestamp(DateTime? timestamp) {
    if (timestamp == null) return '';
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}';
  }
}
