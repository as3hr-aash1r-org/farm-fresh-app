import 'package:dio/dio.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart' show PrettyDioLogger;
import '../../helpers/constants.dart';
import '../network_response.dart';
import 'interceptors/dio_retry_interceptor.dart';
import 'interceptors/network_interceptor.dart';

class DioClient {
  DioClient() {
    _initializeDioClient();
  }
  static const int maxRetries = 3;
  static const int retryDelay = 1;

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      responseType: ResponseType.json,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );

  void _initializeDioClient() {
    dio.interceptors.addAll([
      NetworkInterceptor(),
      RetryInterceptor(
        dio: dio,
        options: RetryOptions(
          retries: maxRetries,
          retryInterval: const Duration(seconds: retryDelay),
          retryEvaluator: (error) async {
            if (error.response?.statusCode == 401) {
              AppNavigation.pushReplacement(RouteName.login);
              return false;
            }
            // if (error.type == DioExceptionType.connectionError ||
            //     error.type == DioExceptionType.connectionTimeout ||
            //     (error.response?.statusCode != null &&
            //         error.response!.statusCode! >= 500)) {
            //   return true;
            // }
            return false;
          },
        ),
      ),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: kDebugMode,
      )
    ]);
  }

  static NetworkResponse handleDioError(DioException error) {
    String message = "";
    dynamic data;
    print("Error: ${error.response}");
    if (error.response?.data != null) {
      final responseData = error.response!.data;
      // message = responseData["detail"] ?? "Unknown error occurred";
      data = responseData;
    } else {
      switch (error.type) {
        case DioExceptionType.cancel:
          message = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionError:
          message = "Failed connection to API server";
        case DioExceptionType.connectionTimeout:
          message = "Connection timed out";
        case DioExceptionType.unknown:
          message = "A Server Error Occured!";
          break;
        case DioExceptionType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          message =
              "Received invalid status code: ${error.response?.statusCode}";
          break;
        case DioExceptionType.sendTimeout:
          message = "Send timeout in connection with API server";
          break;
        case DioExceptionType.badCertificate:
          message = "Incorrect certificate";
          break;
      }
    }
    return NetworkResponse(
      message: message,
      data: data,
      failed: true,
    );
  }
}
