import 'package:dio/dio.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure_model.dart';

class ErrorHandler {
  static Failure handle(dynamic exception) {
    if (exception is DioException) {
      final responseData = exception.response?.data;
      if (responseData is Map && responseData['message'] != null) {
        final message = responseData['message'];
        if (message is List) {
          return Failure(errMessage: message.join('\n'));
        }
        return Failure(errMessage: message.toString());
      }
      return _handleRemoteError(exception.toString());
    }

    return const Failure(errMessage: 'Un Expected Error');
  }

  static Failure _handleRemoteError(String message) {
    final errorMessage = message.trim();

    if (errorMessage.contains('401') ||
        errorMessage.contains('Unauthorized') ||
        errorMessage.contains('Unauthenticated')) {
      return const Failure(errMessage: "Unauthorized");
    }

    if (errorMessage.contains('403') || errorMessage.contains('Forbidden')) {
      return const Failure(errMessage: 'Forbidden');
    }

    if (errorMessage.contains('404') || errorMessage.contains('Not Found')) {
      return const Failure(errMessage: '404 Not Found');
    }

    if (errorMessage.contains('422') ||
        errorMessage.contains('Unprocessable Content')) {
      return const Failure(errMessage: 'Unprocessable Content');
    }

    if (errorMessage.contains('500') ||
        errorMessage.contains('Internal Server Error')) {
      return const Failure(errMessage: 'Internal Server Error');
    }

    if (errorMessage.contains('SocketException') ||
        errorMessage.contains('Connection failed') ||
        errorMessage.contains('HandshakeException')) {
      return const Failure(errMessage: 'No Internet Connection');
    }

    return const Failure(errMessage: 'Un Expected Error');
  }
}
