import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String id;
  final List<String> participantIds;
  final String lastMessageText;
  final DateTime lastMessageTimestamp;
  final bool isGroup;
  final String? groupName;
  final String? groupImageUrl;
  final Map<String, int> unreadCounts;

  ChatModel({
    required this.id,
    required this.participantIds,
    required this.lastMessageText,
    required this.lastMessageTimestamp,
    required this.isGroup,
    this.groupName,
    this.groupImageUrl,
    required this.unreadCounts,
  });

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'],
      participantIds: List<String>.from(map['participant_ids']),
      lastMessageText: map['last_message_text'],
      lastMessageTimestamp:
          (map['last_message_timestamp'] as Timestamp).toDate(),
      isGroup: map['is_group'],
      groupName: map['group_name'],
      groupImageUrl: map['group_image_url'],
      unreadCounts: Map<String, int>.from(map['unread_counts']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'participant_ids': participantIds,
      'last_message_text': lastMessageText,
      'last_message_timestamp': Timestamp.fromDate(lastMessageTimestamp),
      'is_group': isGroup,
      'group_name': groupName,
      'group_image_url': groupImageUrl,
      'unread_counts': unreadCounts,
    };
  }
}
