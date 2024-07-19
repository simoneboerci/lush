import 'package:lush_app/models/message_model.dart';

class ChatModel {
  final String id;
  final List<String> userIds;
  final List<MessageModel> messages;
  final MessageModel? lastMessage;

  static const String idLabel = 'id';
  static const String userIdsLabel = 'user_ids';
  static const String messagesLabel = 'messages';
  static const String lastMessageLabel = 'last_message';

  ChatModel({
    required this.id,
    required this.userIds,
    this.messages = const [],
    this.lastMessage,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map[idLabel] as String,
      userIds: List<String>.from(map[userIdsLabel]),
      messages: List<MessageModel>.from(map[messagesLabel]),
      lastMessage: map[lastMessageLabel] as MessageModel?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      idLabel: id,
      userIdsLabel: userIds,
      messagesLabel: messages,
      lastMessageLabel: lastMessage
    };
  }
}
