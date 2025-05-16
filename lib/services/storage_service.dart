import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  // Keys for shared preferences
  static const String userKey = 'user';
  static const String cartKey = 'cart';
  static const String ordersKey = 'orders';
  static const String themeKey = 'theme';
  static const String languageKey = 'language';
  static const String tokenKey = 'auth_token';

  // Singleton instance
  static final StorageService _instance = StorageService._internal();

  // Factory constructor
  factory StorageService() => _instance;

  // Internal constructor
  StorageService._internal();

  // Save data to shared preferences
  Future<bool> saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is String) {
      return prefs.setString(key, value);
    } else if (value is int) {
      return prefs.setInt(key, value);
    } else if (value is double) {
      return prefs.setDouble(key, value);
    } else if (value is bool) {
      return prefs.setBool(key, value);
    } else if (value is List<String>) {
      return prefs.setStringList(key, value);
    } else {
      // Convert complex objects to JSON string
      return prefs.setString(key, json.encode(value));
    }
  }

  // Get data from shared preferences
  Future<dynamic> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  // Get string data from shared preferences
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Get int data from shared preferences
  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  // Get double data from shared preferences
  Future<double?> getDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }

  // Get bool data from shared preferences
  Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Get string list data from shared preferences
  Future<List<String>?> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  // Get JSON data from shared preferences
  Future<dynamic> getJson(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString != null) {
      return json.decode(jsonString);
    }
    return null;
  }

  // Remove data from shared preferences
  Future<bool> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // Clear all data from shared preferences
  Future<bool> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  // Check if key exists in shared preferences
  Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  // Save authentication token
  Future<bool> saveToken(String token) async {
    return saveData(tokenKey, token);
  }

  // Get authentication token
  Future<String?> getToken() async {
    return getString(tokenKey);
  }

  // Remove authentication token (logout)
  Future<bool> removeToken() async {
    return removeData(tokenKey);
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}
