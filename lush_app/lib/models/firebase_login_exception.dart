class FirebaseLoginException implements Exception {
  final String message;

  FirebaseLoginException(this.message);

  @override
  String toString() => 'LoginException: $message';
}
