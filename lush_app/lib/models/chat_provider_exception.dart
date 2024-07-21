class ChatProviderException implements Exception {
  final String message;

  ChatProviderException(this.message);

  @override
  String toString() => 'ChatProviderException: $message';
}
