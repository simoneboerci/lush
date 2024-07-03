import 'package:cloud_firestore/cloud_firestore.dart';

class DirectMessage {
  final String text;
  final String sender;
  final Timestamp timestamp;

  DirectMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
  });
}
