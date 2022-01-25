/// Base Exception
class AppHttpClientException<OriginalException extends Exception>
    implements Exception {
  ///constructor
  AppHttpClientException({required this.exception});

  /// Exception to be thrown
  final OriginalException exception;
}
