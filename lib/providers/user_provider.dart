import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final ApiService _apiService = ApiService();
  final StorageService _storageService = StorageService();
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoggedIn => _user != null;
  bool get isLoading => _isLoading;

  // Set user and notify listeners
  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  // Login with email/username and password
  Future<bool> login(String username, String password) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Make login request
      final response = await _apiService.postForm('api/v1/auth/login', {
        'username': username,
        'password': password,
      });

      // Save token
      await _storageService.saveToken(response['access_token']);

      // Get user info
      await fetchUserData();
      return true;
    } catch (e) {
      print('Login error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register a new user
  Future<bool> register({
    required String username,
    required String email,
    required String password,
    required String address,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      // Register user
      await _apiService.post('api/v1/auth/register', {
        'username': username,
        'email': email,
        'password': password,
        'address': address,
      });

      // Login with new credentials
      return await login(email, password);
    } catch (e) {
      print('Registration error: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await _storageService.removeToken();
      _user = null;
      notifyListeners();
    } catch (e) {
      print('Logout error: $e');
    }
  }

  // Fetch user data from API using stored token
  Future<void> fetchUserData() async {
    try {
      _isLoading = true;
      notifyListeners();

      // Check if token exists
      final isAuth = await _storageService.isAuthenticated();
      if (!isAuth) {
        _user = null;
        return;
      }

      // Get user info
      final userResponse = await _apiService.post('api/v1/auth/test-token', {});

      // Create user object
      _user = User(
        id: userResponse['id'].toString(),
        name: userResponse['username'] ?? 'User',
        email: userResponse['email'],
        phone: userResponse['phone_number'] ?? '',
        address: userResponse['address'] ?? '',
      );
    } catch (e) {
      print('Fetch user data error: $e');
      _user = null;
      await _storageService.removeToken();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
