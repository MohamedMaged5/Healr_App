import 'package:dio/dio.dart';

abstract class Failure {
  final String errMessage;
  Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);
  @override
  String toString() {
    return errMessage;
  }

  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
            'Connection timeout with the server. Please try again.');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout while connecting to the server.');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Server is taking too long to respond.');
      case DioExceptionType.badCertificate:
        return ServerFailure('Invalid SSL certificate detected.');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioException.response?.statusCode ?? 500,
            dioException.response?.data);
      case DioExceptionType.cancel:
        return ServerFailure('Request was canceled.');
      case DioExceptionType.connectionError:
        return ServerFailure(
            'No internet connection. Please check your network.');
      case DioExceptionType.unknown:
        if (dioException.message != null &&
            dioException.message!.contains('SocketException')) {
          return ServerFailure(
              'No internet connection. Please check your network.');
        }
        return ServerFailure('Unexpected error occurred. Please try again.');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      final message = response['message'] ?? response['errors']['msg'];
      return ServerFailure(message);
    } else if (statusCode == 404) {
      return ServerFailure('Resource not found.');
    } else if (statusCode == 500) {
      return ServerFailure('Server error. Please try again later.');
    } else {
      return ServerFailure('Unexpected server response. Try again later.');
    }
  }
}
