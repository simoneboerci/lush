import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final String? replyToMessageId;

  static const idLabel = 'id';
  static const chatIdLabel = 'chat_id';
  static const senderIdLabel = 'sender_id';
  static const textLabel = 'text';
  static const timestampLabel = 'timestamp';
  static const replyToMessageIdLabel = 'reply_to_message_id';

  MessageModel({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.replyToMessageId,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map[idLabel] as String? ?? '',
      chatId: map[chatIdLabel] as String? ?? '',
      senderId: map[senderIdLabel] as String? ?? '',
      text: map[textLabel] as String? ?? '',
      timestamp: (map[timestampLabel] as Timestamp).toDate(),
      replyToMessageId: map[replyToMessageIdLabel] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      MessageModel.idLabel: id,
      MessageModel.chatIdLabel: chatId,
      MessageModel.senderIdLabel: senderId,
      MessageModel.textLabel: text,
      MessageModel.timestampLabel: Timestamp.fromDate(timestamp),
      MessageModel.replyToMessageIdLabel: replyToMessageId,
    };
  }
}
