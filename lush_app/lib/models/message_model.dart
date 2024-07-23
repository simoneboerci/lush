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

enum MediaType { image, video }

extension MediaTypeExtension on MediaType {
  String toStringValue() => toString().split('.').last;

  static MediaType fromString(String type) {
    return MediaType.values.firstWhere(
        (e) => e.toString().split('.').last == type,
        orElse: () => throw ArgumentError('Invalid media type: $type'));
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
  mediaUrl,
  mediaType,
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
    String? mediaUrl,
    MediaType? mediaType,
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
  final String? mediaUrl;
  final MediaType? mediaType;

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
    this.favorites = const {},
    this.mediaUrl,
    this.mediaType,
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
      mediaUrl: map[MessageModelField.mediaUrl.name] as String?,
      mediaType: map[MessageModelField.mediaType.name] != null
          ? MediaTypeExtension.fromString(map[MessageModelField.mediaType.name])
          : null,
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
      MessageModelField.mediaUrl.name: mediaUrl,
      MessageModelField.mediaType.name: mediaType,
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
    String? mediaUrl,
    MediaType? mediaType,
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
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
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
        mediaUrl,
        mediaType,
      ];
}
