import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../constants/app_constants.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  String _selectedCategory = 'All';
  String _searchQuery = '';
  bool _isLoading = false;
  final ApiService _apiService = ApiService();

  ProductProvider() {
    // Initial state is empty, products will be loaded by fetchProducts
  }

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Getter for search query
  String get searchQuery => _searchQuery;

  // Getter for filtered products based on type and search query
  List<Product> get products {
    List<Product> filteredProducts = _selectedCategory == 'All'
        ? [..._products]
        : _products
            .where((product) => product.type == _selectedCategory)
            .toList();

    // Apply search filter if search query is not empty
    if (_searchQuery.isNotEmpty) {
      filteredProducts = filteredProducts.where((product) {
        return product.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
      }).toList();
    }

    return filteredProducts;
  }

  List<Product> get featuredProducts {
    return _products.where((product) => product.inStock).take(3).toList();
  }

  String get selectedCategory => _selectedCategory;

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  Product findById(String id) {
    return _products.firstWhere((product) => product.id == id);
  }

  void _loadDummyProducts() {
    _products = AppConstants.dummyProducts
        .map((productData) => Product.fromJson(productData))
        .toList();
  }

  // Set search query
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Clear search query
  void clearSearch() {
    _searchQuery = '';
    notifyListeners();
  }

  // Fetch products from the API
  Future<void> fetchProducts() async {
    if (_isLoading) return; // Prevent multiple simultaneous calls
    
    try {
      _isLoading = true;
      notifyListeners();

      // Fetch products from API
      final response = await _apiService.get('api/v1/products');
      dev.log('API Response: ${response.toString().substring(0, min(100, response.toString().length))}...', name: 'ProductProvider');

      // Validate response is a List
      if (response is! List) {
        dev.log('Invalid response format: Expected a List but got ${response.runtimeType}', name: 'ProductProvider');
        throw Exception('Invalid response format');
      }

      // Convert response to Product objects
      final List<dynamic> productsData = response;
      _products = productsData
          .map((productData) => Product.fromJson(productData))
          .toList();
      
      dev.log('Loaded ${_products.length} products successfully', name: 'ProductProvider');
    } catch (e, stackTrace) {
      dev.log('Error fetching products: $e', name: 'ProductProvider');
      dev.log('Stack trace: $stackTrace', name: 'ProductProvider');
      // Fallback to dummy data if API fails
      _loadDummyProducts();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Search products via API
  Future<void> searchProducts(String query) async {
    try {
      _isLoading = true;
      _searchQuery = query;
      notifyListeners();

      // Search products from API
      final response = await _apiService.get('api/v1/products?search=$query');

      // Convert response to Product objects
      final List<dynamic> productsData = response;
      _products = productsData
          .map((productData) => Product.fromJson(productData))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print('Error searching products: $e');
      // Keep existing products but apply search filter in-memory
      _searchQuery = query;

      _isLoading = false;
      notifyListeners();
    }
  }
}
