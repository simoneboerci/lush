import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lush_app/features/chat/data/models/message_model.dart';

enum ChatModelField {
  id,
  ownerId,
  participantIds,
  messages,
  pinnedMessageIds,
  favoriteBy,
  archivedBy,
  pinnedBy,
}

@immutable
class ChatModel extends Equatable {
  final String id;
  final String ownerId;
  final List<String> participantIds;
  final List<MessageModel> messages;
  final List<String> pinnedMessageIds;
  final List<String> favoriteBy;
  final List<String> archivedBy;
  final List<String> pinnedBy;

  const ChatModel({
    required this.id,
    required this.ownerId,
    required this.participantIds,
    this.messages = const [],
    this.pinnedMessageIds = const [],
    this.favoriteBy = const [],
    this.archivedBy = const [],
    this.pinnedBy = const [],
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map[ChatModelField.id.name] as String? ?? '',
      ownerId: map[ChatModelField.ownerId.name] as String? ?? '',
      participantIds:
          map[ChatModelField.participantIds.name] as List<String>? ?? [],
      messages: (map[ChatModelField.messages.name] as List<dynamic>?)
              ?.map(
                  (item) => MessageModel.fromMap(item as Map<String, dynamic>))
              .toList() ??
          [],
      pinnedMessageIds:
          map[ChatModelField.pinnedMessageIds.name] as List<String>? ?? [],
      favoriteBy: map[ChatModelField.favoriteBy.name] as List<String>? ?? [],
      archivedBy: map[ChatModelField.archivedBy.name] as List<String>? ?? [],
      pinnedBy: map[ChatModelField.pinnedBy.name] as List<String>? ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ChatModelField.id.name: id,
      ChatModelField.ownerId.name: ownerId,
      ChatModelField.participantIds.name: participantIds,
      ChatModelField.messages.name:
          messages.map((message) => message.toMap()).toList(),
      ChatModelField.pinnedMessageIds.name: pinnedMessageIds,
      ChatModelField.favoriteBy.name: favoriteBy,
      ChatModelField.archivedBy.name: archivedBy,
      ChatModelField.pinnedBy.name: pinnedBy,
    };
  }

  ChatModel copyWith({
    String? id,
    String? ownerId,
    List<String>? participantIds,
    List<MessageModel>? messages,
    List<String>? pinnedMessageIds,
    List<String>? favoriteBy,
    List<String>? archivedBy,
    List<String>? pinnedBy,
  }) {
    return ChatModel(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      participantIds: participantIds ?? this.participantIds,
      messages: messages ?? this.messages,
      pinnedMessageIds: pinnedMessageIds ?? this.pinnedMessageIds,
      favoriteBy: favoriteBy ?? this.favoriteBy,
      archivedBy: archivedBy ?? this.archivedBy,
      pinnedBy: pinnedBy ?? this.pinnedBy,
    );
  }

  @override
  List<Object?> get props => [
        id,
        ownerId,
        participantIds,
        messages,
        pinnedMessageIds,
        favoriteBy,
        archivedBy,
        pinnedBy,
      ];
}
