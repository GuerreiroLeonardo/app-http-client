// ignore_for_file: public_member_api_docs
import 'package:app_http_client/src/base_http_exception.dart';

enum AppNetworkExceptionReason { canceled, timedOut, responseError }

class AppNetworkException<OriginalException extends Exception>
    extends AppHttpClientException<OriginalException> {
  /// Create a network exception.
  AppNetworkException({
    required this.reason,
    required OriginalException exception,
  }) : super(exception: exception);

  /// The reason the network exception ocurred.
  final AppNetworkExceptionReason reason;
}
