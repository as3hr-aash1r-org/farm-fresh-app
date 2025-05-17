import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:farm_fresh_shop_app/di/initializer.dart';

class NetworkInterceptor extends Interceptor {
  String _tokenValue = "";

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    dynamic data = response.data;

    if (data is String) {
      data = jsonDecode(data);
    }

    if (data is Map<String, dynamic> && data['access_token'] != null) {
      _tokenValue = data['access_token'].toString();
      log("Token found: $_tokenValue");
      localStorageRepository.setValue("token", _tokenValue);
    }

    final newResp = Response(
      requestOptions: response.requestOptions,
      data: data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      headers: response.headers,
      isRedirect: response.isRedirect,
      redirects: response.redirects,
      extra: response.extra,
    );

    return handler.next(newResp);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await localStorageRepository
        .getValue("token")
        .then((value) => value.fold((l) => null, (r) => r));
    if (token != null) {
      log("Adding token to request: $token");
      options.headers['Authorization'] = 'Bearer $token';
    }
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("Interceptor Error: ${err.message}");
    return handler.next(err);
  }
}
