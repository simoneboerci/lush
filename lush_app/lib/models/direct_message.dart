import 'package:cloud_firestore/cloud_firestore.dart';

class DirectMessage {
  final String id;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isDelivered;
  final bool isRead;
  final String? imageUrl;
  final String? fileUrl;
  final String? replyToMessageId;

  DirectMessage({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    required this.isDelivered,
    required this.isRead,
    this.imageUrl,
    this.fileUrl,
    this.replyToMessageId,
  });

  factory DirectMessage.fromMap(Map<String, dynamic> map) {
    return DirectMessage(
      id: map['id'],
      chatId: map['chat_id'],
      senderId: map['sender_id'],
      text: map['text'],
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      isDelivered: map['is_delivered'],
      isRead: map['is_read'],
      imageUrl: map['image_url'],
      fileUrl: map['file_url'],
      replyToMessageId: map['reply_to_message_id'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'chat_id': chatId,
      'sender_id': senderId,
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
      'is_delivered': isDelivered,
      'is_read': isRead,
      'image_url': imageUrl,
      'file_url': fileUrl,
      'reply_to_message_id': replyToMessageId,
    };
  }
}
