import 'package:dio/dio.dart';
import 'package:inpo_mobile_app/core/utils/logger.dart';

class ErrorHandler {
  static Exception handleDioError(DioException e) {
    AppLogger.error('Dio error occurred: ${e.toString()}', e);

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception(
            'Timeout error: Connection timed out. Please check your internet connection.');

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return Exception('Request cancelled');

      case DioExceptionType.unknown:
        return _handleUnknownError(e);

      case DioExceptionType.badCertificate:
        return Exception(
            'SSL certificate error: The connection is not secure.');

      case DioExceptionType.connectionError:
        return Exception(
            'Connection error: Unable to connect to the server. Please check your internet connection.');
    }
  }

  static Exception _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    AppLogger.error('Bad response: Status $statusCode, Data: $responseData');

    switch (statusCode) {
      case 400:
        return Exception(
            'Bad request: The server could not understand your request.');
      case 401:
        return Exception(
            'Unauthorized: Please authenticate to access this resource.');
      case 403:
        return Exception(
            'Forbidden: You don\'t have permission to access this resource.');
      case 404:
        return Exception(
            'Not found: The requested resource could not be found.');
      case 429:
        return Exception('Too many requests: Please wait and try again later.');
      case 500:
        return Exception('Server error: An internal server error occurred.');
      case 502:
        return Exception(
            'Bad gateway: The server received an invalid response.');
      case 503:
        return Exception(
            'Service unavailable: The server is temporarily unavailable.');
      case 504:
        return Exception(
            'Gateway timeout: The server did not receive a timely response.');
      default:
        return Exception(
            'Server error: An error occurred while processing your request (Status: $statusCode).');
    }
  }

  static Exception _handleUnknownError(DioException e) {
    if (e.error is FormatException) {
      return Exception('Data format error: Unable to parse the response data.');
    } else if (e.error is TypeError) {
      return Exception('Type error: Invalid data type received.');
    } else if (e.error.toString().contains('SocketException')) {
      return Exception(
          'Network error: Unable to connect to the server. Please check your internet connection.');
    } else {
      return Exception(
          'Unknown error: ${e.error?.toString() ?? 'No additional error information'}');
    }
  }

  static Exception handleParsingError(dynamic e, String context) {
    AppLogger.error('Parsing error in $context: ${e.toString()}', e);
    return Exception(
        'Data parsing error: Unable to process the received data.');
  }

  static Exception handleGeneralError(dynamic e, String context) {
    AppLogger.error('General error in $context: ${e.toString()}', e);
    return Exception('An unexpected error occurred: ${e.toString()}');
  }
}
