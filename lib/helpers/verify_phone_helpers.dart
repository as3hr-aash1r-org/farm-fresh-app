import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class VerifyPhoneHelper {
  final phoneNumber = '';
  final countryCode = '+92';
  int remainingSeconds = 0;
  final verificationCode = ['', '', '', '', '']; // Changed to 5 digits
  final focusNodes = List.generate(5, (index) => FocusNode()); // Changed to 5
  Timer? _timer;

  // Stream controller for timer updates
  final StreamController<int> _timerController =
      StreamController<int>.broadcast();
  Stream<int> get timerStream => _timerController.stream;

  void updateVerificationDigit(int index, String value) {
    if (value.isNotEmpty && value.length == 1) {
      // Handle input
      if (index >= 0 && index < 5) {
        verificationCode[index] = value;
        if (index < 4) {
          focusNodes[index + 1].requestFocus();
        } else {
          // Last field, unfocus
          focusNodes[index].unfocus();
        }
      }
    } else if (value.isEmpty) {
      // Handle backspace
      if (index >= 0 && index < 5) {
        verificationCode[index] = '';
        if (index > 0) {
          focusNodes[index - 1].requestFocus();
        }
      }
    }
  }

  String getFullPhoneNumber() {
    return '${countryCode} ${phoneNumber}';
  }

  bool isVerificationCodeComplete() {
    return !verificationCode.contains('') && verificationCode.length == 5;
  }

  String getOtp() {
    return verificationCode.join("");
  }

  bool isValidPhoneNumber() {
    final phone = getFullPhoneNumber();
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    log(cleanPhone);

    if (RegExp(r'^\+[1-9]\d{6,14}$').hasMatch(cleanPhone)) {
      return true;
    }
    return false;
  }

  String? validatePhoneNumber(String? phone) {
    if (phone == null || phone.isEmpty) {
      return 'Phone number is required';
    }

    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');

    if (cleanPhone.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    if (cleanPhone.length > 15) {
      return 'Phone number cannot exceed 15 digits';
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(cleanPhone)) {
      return 'Phone number can only contain digits';
    }

    return null;
  }

  void startCountdown({int seconds = 40}) {
    _timer?.cancel();
    remainingSeconds = seconds;
    _timerController.add(remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        _timerController.add(remainingSeconds);
      } else {
        timer.cancel();
        _timerController.add(0);
      }
    });
  }

  void resendCode() {
    // Clear existing OTP
    for (int i = 0; i < verificationCode.length; i++) {
      verificationCode[i] = '';
    }
    // Focus first field
    if (focusNodes.isNotEmpty) {
      focusNodes[0].requestFocus();
    }
    // Restart timer
    startCountdown();
  }

  String getFormattedTime() {
    int minutes = remainingSeconds ~/ 60;
    int seconds = remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get canResend => remainingSeconds == 0;

  void clearOtp() {
    for (int i = 0; i < verificationCode.length; i++) {
      verificationCode[i] = '';
    }
    if (focusNodes.isNotEmpty) {
      focusNodes[0].requestFocus();
    }
  }

  void dispose() {
    _timer?.cancel();
    _timerController.close();
    for (var node in focusNodes) {
      node.dispose();
    }
  }
}
