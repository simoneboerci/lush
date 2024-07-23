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

enum MessageModelField {
  id,
  chatId,
  senderId,
  text,
  timestamp,
  status,
  replyToMessageId,
  favorites,
}

abstract class IMessageModel extends Equatable {
  Map<String, dynamic> toMap();
  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? text,
    DateTime? timestamp,
    MessageStatus? status,
    String? replyToMessageId,
    Map<String, bool>? favorites,
  });

  bool isFavoriteForUser(String userId);
}

@immutable
class MessageModel extends IMessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final MessageStatus status;
  final String? replyToMessageId;
  final Map<String, bool> favorites;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
    this.favorites = const {},
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map[MessageModelField.id.name] as String? ?? '',
      chatId: map[MessageModelField.chatId.name] as String? ?? '',
      senderId: map[MessageModelField.senderId.name] as String? ?? '',
      text: map[MessageModelField.text.name] as String? ?? '',
      timestamp:
          (map[MessageModelField.timestamp.name] as Timestamp?)?.toDate() ??
              DateTime.now(),
      status: MessageStatusExtension.fromString(
          map[MessageModelField.status.name] as String? ??
              MessageStatus.sent.toStringValue()),
      replyToMessageId: map[MessageModelField.replyToMessageId.name] as String?,
      favorites:
          Map<String, bool>.from(map[MessageModelField.favorites.name] ?? {}),
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      MessageModelField.id.name: id,
      MessageModelField.chatId.name: chatId,
      MessageModelField.senderId.name: senderId,
      MessageModelField.text.name: text,
      MessageModelField.timestamp.name: Timestamp.fromDate(timestamp),
      MessageModelField.status.name: status.toStringValue(),
      MessageModelField.replyToMessageId.name: replyToMessageId,
      MessageModelField.favorites.name: favorites,
    };
  }

  @override
  MessageModel copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? text,
    DateTime? timestamp,
    MessageStatus? status,
    String? replyToMessageId,
    Map<String, bool>? favorites,
  }) {
    return MessageModel(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      text: text ?? this.text,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  bool isFavoriteForUser(String userId) => favorites[userId] ?? false;

  @override
  List<Object?> get props => [
        id,
        chatId,
        senderId,
        text,
        timestamp,
        status,
        replyToMessageId,
        favorites,
      ];
}
