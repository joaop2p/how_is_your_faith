class BibleApiException implements Exception {
  final String message;

  BibleApiException(this.message);

  @override
  String toString() => 'BibleApiException: $message';
}
