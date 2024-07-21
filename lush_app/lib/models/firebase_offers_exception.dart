class FirebaseOffersException implements Exception {
  final String message;

  FirebaseOffersException(this.message);

  @override
  String toString() => 'FirebaseOffersException: $message';
}
