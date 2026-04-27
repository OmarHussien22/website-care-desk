import 'package:dio/dio.dart';
import 'package:coursaty/src/core/network_structure/exceptions/failure.dart';
import 'package:coursaty/src/core/network_structure/networking/src/interfaces/handler/error_handler.dart';
import 'package:coursaty/src/core/network_structure/networking/src/utils/status_handler.dart';

class DioErrorHandler extends ErrorHandler<DioException> {
  DioErrorHandler._();

  static final DioErrorHandler instance = DioErrorHandler._();

  @override
  void handleError(DioException error) {
    if (error.response.toString().contains("SocketException")) {
      throw NetworkDisconnectException('Network Disconnect Exception');
    } else {
      _handleError(error);
    }
  }

  void _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeoutRequestException('Connection Timeout');
      case DioExceptionType.sendTimeout:
        throw TimeoutRequestException('Send Timeout');
      case DioExceptionType.receiveTimeout:
        throw TimeoutRequestException('Receive Timeout');
      case DioExceptionType.badResponse:
        StatusHandler.instance.handleStatusCode(
          error.response?.statusCode ?? 0,
        );
        break;
      case DioExceptionType.cancel:
        throw TimeoutRequestException('Request Cancelled');
      case DioExceptionType.unknown:
        throw UnKnownException('Unknown Error');
      case DioExceptionType.badCertificate:
        throw UnKnownException('Bad Certificate');
      case DioExceptionType.connectionError:
        throw UnKnownException('Connection Error');
    }
  }
}
