import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MessageStatus { sent, delivered, read }

extension MessageStatusExtension on MessageStatus {
  String toStringValue() => toString().split('.').last;

  static MessageStatus fromString(String status) {
    return MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
        orElse: () => throw ArgumentError('Invalid Message status: $status'));
  }
}

@immutable
class MessageModel extends Equatable {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final MessageStatus status;
  final String? replyToMessageId;

  static const idLabel = 'id';
  static const chatIdLabel = 'chat_id';
  static const senderIdLabel = 'sender_id';
  static const textLabel = 'text';
  static const timestampLabel = 'timestamp';
  static const statusLabel = 'status';
  static const replyToMessageIdLabel = 'reply_to_message_id';

  const MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map[idLabel] as String? ?? '',
      chatId: map[chatIdLabel] as String? ?? '',
      senderId: map[senderIdLabel] as String? ?? '',
      text: map[textLabel] as String? ?? '',
      timestamp:
          (map[timestampLabel] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: MessageStatusExtension.fromString(
          map[statusLabel] as String? ?? MessageStatus.sent.toStringValue()),
      replyToMessageId: map[replyToMessageIdLabel] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idLabel: id,
      chatIdLabel: chatId,
      senderIdLabel: senderId,
      textLabel: text,
      timestampLabel: Timestamp.fromDate(timestamp),
      statusLabel: status.toStringValue(),
      replyToMessageIdLabel: replyToMessageId,
    };
  }

  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? text,
    DateTime? timestamp,
    MessageStatus? status,
    String? replyToMessageId,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
    );
  }

  @override
  List<Object?> get props =>
      [id, chatId, senderId, text, timestamp, status, replyToMessageId];
}
