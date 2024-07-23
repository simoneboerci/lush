class FirebaseChatException implements Exception {
  final String message;

  FirebaseChatException(this.message);

  @override
  String toString() => 'ChatException: $message';
}
