import 'dart:convert';
import 'package:http/http.dart' as http;
import 'storage_service.dart';

class ApiService {
  // Base URL for the API
  // static const String baseUrl = 'http://10.0.2.2:8000'; // Use 10.0.2.2 for Android emulator to access host's localhost
  // static const String baseUrl = 'http://localhost:8000'; // Use for web or iOS simulator
  static const String baseUrl =
      'http://192.168.1.108:8000'; // Use for physical device on same network

  // HTTP client
  final http.Client _client = http.Client();

  // Storage service for token management
  final StorageService _storageService = StorageService();

  // Singleton instance
  static final ApiService _instance = ApiService._internal();

  // Factory constructor
  factory ApiService() => _instance;

  // Internal constructor
  ApiService._internal();

  // GET request
  Future<dynamic> get(String endpoint) async {
    try {
      // Get auth token if available
      final token = await _storageService.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _client.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to perform GET request: $e');
    }
  }

  // POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      // Get auth token if available
      final token = await _storageService.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _client.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: json.encode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to perform POST request: $e');
    }
  }

  // New method for sending form-data (application/x-www-form-urlencoded)
  Future<dynamic> postForm(String endpoint, Map<String, String> data) async {
    try {
      final token = await _storageService.getToken();
      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _client.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: data, // Don't json.encode here — this is form-encoded
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to perform FORM POST request: $e');
    }
  }

  // PUT request
  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    try {
      // Get auth token if available
      final token = await _storageService.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _client.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: json.encode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to perform PUT request: $e');
    }
  }

  // DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      // Get auth token if available
      final token = await _storageService.getToken();
      final headers = {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      };

      final response = await _client.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );

      return _handleResponse(response);
    } catch (e) {
      throw Exception('Failed to perform DELETE request: $e');
    }
  }

  // Handle HTTP response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Success response
      if (response.body.isNotEmpty) {
        return json.decode(response.body);
      }
      return null;
    } else {
      // Error response
      throw Exception('HTTP Error: ${response.statusCode}, ${response.body}');
    }
  }

  // Dispose resources
  void dispose() {
    _client.close();
  }
}
