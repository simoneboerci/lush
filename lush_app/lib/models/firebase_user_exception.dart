class FirebaseUserException implements Exception {
  final String message;

  FirebaseUserException(this.message);

  @override
  String toString() => 'FirebaseUserException: $message';
}
