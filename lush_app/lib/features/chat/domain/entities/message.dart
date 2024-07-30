import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum MessageStatus { sent, delivered, read }

enum MediaType { image, video }

@immutable
class Message extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final MessageStatus status;
  final String? replyToMessageId;
  final Map<String, bool> hiddenFrom;
  final Map<String, bool> favoritesBy;
  final String? mediaUrl;
  final MediaType? mediaType;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
    this.hiddenFrom = const {},
    this.favoritesBy = const {},
    this.mediaUrl,
    this.mediaType,
  });

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        text,
        timestamp,
        status,
        replyToMessageId,
        hiddenFrom,
        favoritesBy,
        mediaUrl,
        mediaType
      ];
}
