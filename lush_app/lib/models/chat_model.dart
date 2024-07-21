import 'package:flutter/foundation.dart';

import 'package:equatable/equatable.dart';

import 'package:lush_app/models/message_model.dart';

@immutable
class ChatModel extends Equatable {
  final String id;
  final List<String> userIds;
  final List<MessageModel> messages;
  final String? lastMessageId;

  static const String idLabel = 'id';
  static const String userIdsLabel = 'user_ids';
  static const String messagesLabel = 'messages';
  static const String lastMessageIdLabel = 'last_message_id';

  ChatModel({
    required this.id,
    required List<String> userIds,
    List<MessageModel> messages = const [],
    this.lastMessageId,
  })  : userIds = List.unmodifiable(userIds),
        messages = List.unmodifiable(messages);

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map[idLabel] as String? ?? '',
      userIds: List<String>.from(map[userIdsLabel] ?? []),
      messages: (map[messagesLabel] as List<dynamic>?)
              ?.map(
                  (item) => MessageModel.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      lastMessageId: map[lastMessageIdLabel] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idLabel: id,
      userIdsLabel: userIds,
      messagesLabel: messages.map((msg) => msg.toMap()).toList(),
      lastMessageIdLabel: lastMessageId,
    };
  }

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

  MessageModel? getMessage(String id) {
    try {
      return messages.firstWhere((message) => message.id == id);
    } on StateError {
      return null;
    }
  }

  int getUnreadMessagesCount(String userId) {
    return messages
        .where((message) =>
            message.senderId != userId && message.status != MessageStatus.read)
        .length;
  }

  @override
  List<Object?> get props => [id, userIds, messages, lastMessageId];
}
