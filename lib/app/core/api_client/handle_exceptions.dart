import 'package:dio/dio.dart';
import 'package:simple_shopping/app/data/models/app_error_model.dart';

class HandleExceptions {
  HandleExceptions._();

  static AppError handleError({
    required Object error,
  }) {
    if (error is DioException) {
      return _fromDioException(
        dioException: error,
      );
    } else if (error is AppError) {
      return error;
    } else {
      return AppError(
        message: error.toString(),
      );
    }
  }

  static AppError _fromDioException({
    required DioException dioException,
  }) {
    final response = dioException.response;
    String message = dioException.type.message;
    switch (dioException.type) {
      case DioExceptionType.badResponse:
        return _handleDioExceptionResponse(
          response: response,
        );

      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          message = 'No Internet';
        }

      default:
        break;
    }

    return AppError(
      message: message,
    );
  }

  static AppError _handleDioExceptionResponse({
    required Response<dynamic>? response,
  }) {
    final statusCode = response?.statusCode;
    String message = 'Oops something went wrong';
    final data = response?.data;

    if (statusCode != null && statusCode >= 400 && data != null) {
      if (data is Map<String, dynamic>) {
        try {
          return AppError.fromJson(data);
        } catch (error) {
          message = error.toString();
        }
      } else {
        message = data.toString();
      }
    }

    return AppError(
      message: message,
    );
  }
}

extension _DioExceptionTypeExtension on DioExceptionType {
  String get message {
    switch (this) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout with API server';
      case DioExceptionType.sendTimeout:
        return 'Send timeout in connection with API server';
      case DioExceptionType.receiveTimeout:
        return 'Receive timeout in connection with API server';
      case DioExceptionType.badCertificate:
        return 'Bad Certificate';
      case DioExceptionType.badResponse:
        return 'Bad Response';
      case DioExceptionType.cancel:
        return 'Request to API server was cancelled';
      case DioExceptionType.connectionError:
        return 'Connection Error';
      case DioExceptionType.unknown:
        return 'Unexpected error occurred';
    }
  }
}
