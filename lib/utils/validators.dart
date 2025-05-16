class Validators {
  // Email validation
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  // Password validation
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // Name validation
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    return null;
  }

  // Phone validation
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final phoneRegExp = RegExp(r'^[+]?[0-9]{10,15}$');

    if (!phoneRegExp.hasMatch(value.replaceAll(RegExp(r'[\s-]'), ''))) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  // Address validation
  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }

    if (value.length < 5) {
      return 'Please enter a valid address';
    }

    return null;
  }

  // Credit card number validation
  static String? validateCreditCardNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Credit card number is required';
    }

    final cleanValue = value.replaceAll(RegExp(r'\s'), '');

    if (!RegExp(r'^[0-9]{13,19}$').hasMatch(cleanValue)) {
      return 'Please enter a valid credit card number';
    }

    return null;
  }

  // Credit card expiry validation
  static String? validateCreditCardExpiry(String? value) {
    if (value == null || value.isEmpty) {
      return 'Expiry date is required';
    }

    if (!RegExp(r'^(0[1-9]|1[0-2])\/([0-9]{2})$').hasMatch(value)) {
      return 'Please enter a valid expiry date (MM/YY)';
    }

    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final year = int.parse('20${parts[1]}');

    final now = DateTime.now();
    final expiryDate = DateTime(year, month + 1, 0);

    if (expiryDate.isBefore(now)) {
      return 'Card has expired';
    }

    return null;
  }

  // Credit card CVV validation
  static String? validateCreditCardCVV(String? value) {
    if (value == null || value.isEmpty) {
      return 'CVV is required';
    }

    if (!RegExp(r'^[0-9]{3,4}$').hasMatch(value)) {
      return 'Please enter a valid CVV';
    }

    return null;
  }

  // Zip code validation
  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Zip code is required';
    }

    if (!RegExp(r'^[0-9]{5}(?:-[0-9]{4})?$').hasMatch(value)) {
      return 'Please enter a valid zip code';
    }

    return null;
  }

  // Message validation
  static String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }

    if (value.length < 10) {
      return 'Message must be at least 10 characters';
    }

    return null;
  }
}
