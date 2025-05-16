import 'package:flutter/material.dart';
import '../utils/image_assets.dart';

class AppConstants {
  // App Colors
  static const Color primaryColor = Color(0xFF006400); // Dark Green
  static const Color secondaryColor = Color(0xFFF57C00); // Orange
  static const Color backgroundColor = Colors.white;
  static const Color textColor = Color(0xFF212121);
  static const Color lightTextColor = Color(0xFF757575);
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  
  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textColor,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: textColor,
  );
  
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: textColor,
  );
  
  static const TextStyle smallTextStyle = TextStyle(
    fontSize: 14,
    color: lightTextColor,
  );
  
  // App Strings
  static const String appName = 'Farm Fresh Shop';
  static const String appTagline = 'Delivering the Taste of Pakistan to the USA';
  
  // Product Categories
  static const List<String> categories = [
    'Chaunsa',
    'Sindhri',
    'Anwar Ratol',
    'All',
  ];
  
  // Dummy Data for Development
  static List<Map<String, dynamic>> dummyProducts = [
    {
      'id': '1',
      'name': 'SB Chaunsa Mango',
      'description': 'SB Chaunsa is known for its sweet, aromatic flavor and smooth texture.',
      'price': 34.99,
      'imageUrl': ImageAssets.chaunsaMango,
      'inStock': true,
      'estimatedPickupDateRange': 'July 1 - July 4',
      'category': 'Chaunsa',
    },
    {
      'id': '2',
      'name': 'Sindhri Mango',
      'description': 'Sindhri mangoes are known for their unique flavor and large size.',
      'price': 34.99,
      'imageUrl': ImageAssets.sindhriMango,
      'inStock': true,
      'estimatedPickupDateRange': 'June 15 - June 20',
      'category': 'Sindhri',
    },
    {
      'id': '3',
      'name': 'Anwar Ratol Mango',
      'description': 'Anwar Ratol is a small-sized mango with an incredibly sweet taste.',
      'price': 39.99,
      'imageUrl': ImageAssets.anwarRatolMango,
      'inStock': false,
      'estimatedPickupDateRange': 'July 10 - July 15',
      'category': 'Anwar Ratol',
    },
  ];
}
