import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

import 'package:lush_app/models/message_model.dart';

enum ChatModelField {
  id,
  userIds,
  messages,
  lastMessageId,
}

abstract class IChatModel extends Equatable {
  Map<String, dynamic> toMap();
  ChatModel copyWith({
    String? id,
    List<String>? userIds,
    List<MessageModel>? messages,
    String? lastMessageId,
  });

  MessageModel? getMessageFromId(String messageId);
  int getUnreadMessagesCount(String userId);

  List<MessageModel> getFavoriteMessagesForUser(String userId);
}

@immutable
class ChatModel extends IChatModel {
  final String id;
  final List<String> userIds;
  final List<MessageModel> messages;
  final String? lastMessageId;

  ChatModel({
    required this.id,
    required List<String> userIds,
    List<MessageModel> messages = const [],
    this.lastMessageId,
  })  : userIds = List.unmodifiable(userIds),
        messages = List.unmodifiable(messages);

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map[ChatModelField.id.name] as String? ?? '',
      userIds: List<String>.from(map[ChatModelField.userIds.name] ?? []),
      messages: (map[ChatModelField.messages.name] as List<dynamic>?)
              ?.map(
                  (item) => MessageModel.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      lastMessageId: map[ChatModelField.lastMessageId.name] as String?,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      ChatModelField.id.name: id,
      ChatModelField.userIds.name: userIds,
      ChatModelField.messages.name: messages.map((msg) => msg.toMap()).toList(),
      ChatModelField.lastMessageId.name: lastMessageId,
    };
  }

  @override
  ChatModel copyWith({
    String? id,
    List<String>? userIds,
    List<MessageModel>? messages,
    String? lastMessageId,
  }) {
    return ChatModel(
      id: id ?? this.id,
      userIds: userIds ?? this.userIds,
      messages: messages ?? this.messages,
      lastMessageId: lastMessageId ?? this.lastMessageId,
    );
  }

  @override
  MessageModel? getMessageFromId(String messageId) {
    try {
      return messages.firstWhere((message) => message.id == messageId);
    } on StateError {
      return null;
    }
  }

  @override
  int getUnreadMessagesCount(String userId) {
    return messages
        .where((message) =>
            message.senderId != userId && message.status != MessageStatus.read)
        .length;
  }

  @override
  List<MessageModel> getFavoriteMessagesForUser(String userId) {
    return messages
        .where((message) => message.isFavoriteForUser(userId))
        .toList();
  }

  @override
  List<Object?> get props => [id, userIds, messages, lastMessageId];
}
