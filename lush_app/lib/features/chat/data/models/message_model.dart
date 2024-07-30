import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lush_app/features/chat/domain/entities/message.dart';

extension MessageStatusExtension on MessageStatus {
  String toStringValue() => toString().split('.').last;

  static MessageStatus fromString(String status) {
    return MessageStatus.values.firstWhere(
        (e) => e.toString().split('.').last == status,
        orElse: () => throw ArgumentError('Invalid Message status: $status'));
  }
}

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
  hiddenFrom,
  favoritesBy,
  mediaUrl,
  mediaType,
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
  final Map<String, bool> hiddenFrom;
  final Map<String, bool> favoritesBy;
  final String? mediaUrl;
  final MediaType? mediaType;

  const MessageModel({
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
      hiddenFrom:
          Map<String, bool>.from(map[MessageModelField.hiddenFrom.name] ?? {}),
      favoritesBy:
          Map<String, bool>.from(map[MessageModelField.favoritesBy.name] ?? {}),
      mediaUrl: map[MessageModelField.mediaUrl.name] as String?,
      mediaType: map[MessageModelField.mediaType.name] != null
          ? MediaTypeExtension.fromString(map[MessageModelField.mediaType.name])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      MessageModelField.id.name: id,
      MessageModelField.chatId.name: chatId,
      MessageModelField.senderId.name: senderId,
      MessageModelField.text.name: text,
      MessageModelField.timestamp.name: Timestamp.fromDate(timestamp),
      MessageModelField.status.name: status.toStringValue(),
      MessageModelField.replyToMessageId.name: replyToMessageId,
      MessageModelField.hiddenFrom.name: hiddenFrom,
      MessageModelField.favoritesBy.name: favoritesBy,
      MessageModelField.mediaUrl.name: mediaUrl,
      MessageModelField.mediaType.name: mediaType?.toStringValue(),
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
    Map<String, bool>? hiddenFrom,
    Map<String, bool>? favoritesBy,
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
      hiddenFrom: hiddenFrom ?? this.hiddenFrom,
      favoritesBy: favoritesBy ?? this.favoritesBy,
      mediaUrl: mediaUrl ?? this.mediaUrl,
      mediaType: mediaType ?? this.mediaType,
    );
  }

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
