import 'package:intl/intl.dart';

class Formatters {
  // Format price
  static String formatPrice(double price) {
    return '${price.toStringAsFixed(2)}';
  }

  // Format date
  static String formatDate(DateTime date) {
    return DateFormat('MMM d, yyyy').format(date);
  }

  // Format date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM d, yyyy - h:mm a').format(dateTime);
  }

  // Format phone number
  static String formatPhoneNumber(String phoneNumber) {
    // Remove all non-digit characters
    final digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');
    
    // Format based on length
    if (digitsOnly.length == 10) {
      // Format as (XXX) XXX-XXXX
      return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
    } else if (digitsOnly.length > 10) {
      // Format as +X (XXX) XXX-XXXX for international numbers
      return '+${digitsOnly.substring(0, digitsOnly.length - 10)} (${digitsOnly.substring(digitsOnly.length - 10, digitsOnly.length - 7)}) ${digitsOnly.substring(digitsOnly.length - 7, digitsOnly.length - 4)}-${digitsOnly.substring(digitsOnly.length - 4)}';
    }
    
    // Return original if can't format
    return phoneNumber;
  }

  // Format credit card number
  static String formatCreditCardNumber(String cardNumber) {
    // Remove all non-digit characters
    final digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    
    // Add a space after every 4 digits
    final buffer = StringBuffer();
    for (var i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      if ((i + 1) % 4 == 0 && i != digitsOnly.length - 1) {
        buffer.write(' ');
      }
    }
    
    return buffer.toString();
  }

  // Mask credit card number (show only last 4 digits)
  static String maskCreditCardNumber(String cardNumber) {
    // Remove all non-digit characters
    final digitsOnly = cardNumber.replaceAll(RegExp(r'\D'), '');
    
    if (digitsOnly.length <= 4) {
      return digitsOnly;
    }
    
    final maskedPart = '*' * (digitsOnly.length - 4);
    final lastFourDigits = digitsOnly.substring(digitsOnly.length - 4);
    
    return '$maskedPart$lastFourDigits';
  }

  // Format file size
  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else if (bytes < 1024 * 1024 * 1024) {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    } else {
      return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
    }
  }

  // Format order status
  static String formatOrderStatus(String status) {
    // Capitalize first letter of each word
    return status.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
