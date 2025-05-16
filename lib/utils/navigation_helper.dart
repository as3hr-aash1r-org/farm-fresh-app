import 'package:flutter/material.dart';

/// Helper class for handling navigation across the app
class NavigationHelper {
  /// Handles navigation based on the bottom navigation bar index
  static void handleNavigation(BuildContext context, int index) {
    final String routeName;
    
    switch (index) {
      case 0:
        routeName = '/';
        break;
      case 1:
        routeName = '/products';
        break;
      case 2:
        routeName = '/cart';
        break;
      case 3:
        routeName = '/profile';
        break;
      case 4:
        routeName = '/contact';
        break;
      default:
        routeName = '/';
    }
    
    // Navigate to the selected screen
    // Use pushReplacementNamed to avoid stacking screens
    Navigator.pushReplacementNamed(context, routeName);
  }
}
