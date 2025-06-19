import 'dart:async';

import 'package:dio/dio.dart';

import 'dio/dio_client.dart';
import 'network_response.dart';

class NetworkRepository {
  final dioClient = DioClient();
  Future<NetworkResponse> request({
    required String method,
    required String url,
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final completer = Completer<NetworkResponse>();
    late NetworkResponse networkResponse;
    try {
      print("HERE");
      final response = await dioClient.dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: Options(method: method),
      );

      print("HERE 1: ${response.data}");
      networkResponse = _handleResponse(response);
      completer.complete(networkResponse);
    } on DioException catch (e) {
      print("IN DIO CATCH: ${e.toString()}");
      if (!completer.isCompleted) {
        networkResponse = DioClient.handleDioError(e);
        networkResponse.failed = true;
        completer.completeError(networkResponse);
        return networkResponse;
      }
    } on NetworkResponse catch (e) {
      print("IN NETWORK RESPONSE CATCH: ${e.toString()}");
      if (!completer.isCompleted) {
        networkResponse = e;
        networkResponse.failed = true;
        completer.completeError(networkResponse);
        return networkResponse;
      }
    } catch (e) {
      print("IN CATCH: ${e.toString()}");
      if (!completer.isCompleted) {
        networkResponse = NetworkResponse(
          message: "An unexpected error occurred",
          data: null,
          status: 500,
          failed: true,
        );
        completer.completeError(networkResponse);
        return networkResponse;
      }
    }

    return networkResponse;
  }

  Future<NetworkResponse> get({
    required String url,
    Map<String, dynamic>? extraQuery,
  }) =>
      request(
        method: 'GET',
        url: url,
        queryParameters: extraQuery,
      );

  Future<NetworkResponse> post({
    required String url,
    Object? data,
  }) =>
      request(
        method: 'POST',
        url: url,
        data: data,
      );

  Future<NetworkResponse> patch({
    required String url,
    Object? data,
  }) =>
      request(
        method: 'PATCH',
        url: url,
        data: data,
      );

  Future<NetworkResponse> put({
    required String url,
    Object? data,
  }) =>
      request(
        method: 'PUT',
        url: url,
        data: data,
      );

  Future<NetworkResponse> delete({required String url}) => request(
        method: 'DELETE',
        url: url,
      );

  NetworkResponse _handleResponse(Response response) {
    print("Handle Response: ${response.data}");
    String message = "";
    if (response.statusCode == 200 || response.statusCode == 201) {
      return NetworkResponse(
        data: response.data,
        message: message,
        status: response.statusCode ?? 200,
      );
    }
    message = response.data["detail"] == null
        ? parseNetworkMessage(response.data["detail"])
        : "Unknown Error Occured";

    throw NetworkResponse(
      failed: true,
      status: response.statusCode ?? 200,
      message: message,
    );
  }

  String parseNetworkMessage(dynamic message) {
    String finalMessage = "";
    if (message is String) {
      finalMessage = message;
    } else if (message is Map<String, dynamic>) {}
    return finalMessage;
  }
}
