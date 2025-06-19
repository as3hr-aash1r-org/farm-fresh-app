import 'dart:async';
import 'package:farm_fresh_shop_app/data/auth/auth_repository.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/helpers/verify_phone_helpers.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_screen_state.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenState> {
  final authRepository = AuthRepository();
  final phoneHelper = VerifyPhoneHelper();
  String email = "";
  String password = "";
  String username = "";
  String newPassword = "";
  String confirmNewPassword = "";
  StreamSubscription? _timerSubscription;
  RegisterScreenCubit() : super(RegisterScreenState.empty());

  initiateOtpScreen() {
    _timerSubscription = phoneHelper.timerStream.listen((remainingTime) {
      emit(state.copyWith(
        remainingTime: remainingTime,
        canResendOtp: remainingTime == 0,
      ));
    });
    phoneHelper.startCountdown();
  }

  void onEmailChange(String val) {
    email = val;
  }

  void onPasswordChange(String val) {
    password = val;
  }

  void onUserNameChange(String val) {
    username = val;
  }

  void onRegister() {
    if (email.isEmpty || password.isEmpty || username.isEmpty) {
      showToast("Please enter email and password and username");
      return;
    }
    emit(state.copyWith(isLoading: true));
    authRepository.register(email, password, username).then(
          (response) => response.fold(
            (error) {
              showToast(error);
              emit(state.copyWith(isLoading: false));
            },
            (user) {
              emit(state.copyWith(isLoading: false));
              AppNavigation.push(RouteName.verifyOtp,
                  arguments: {"isRegister": true});
              showToast("Registration successful, OTP sent successfully");
            },
          ),
        );
  }

  void onVerifyOtp({bool isRegister = false}) {
    if (!phoneHelper.isVerificationCodeComplete()) {
      showToast("Please enter complete OTP");
      return;
    }

    emit(state.copyWith(isLoading: true));

    final otp = phoneHelper.getOtp();

    authRepository.verifyOtp(email: email, otp: otp).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showToast(error);
            },
            (success) {
              emit(state.copyWith(isLoading: false));
              if (isRegister) {
                AppNavigation.pushReplacement(RouteName.bottomBar);
              } else {
                AppNavigation.pushReplacement(RouteName.resetPassword);
              }
              showToast("OTP verified successfully");
            },
          ),
        );
  }

  void onResendOtp() {
    if (phoneHelper.canResend) {
      emit(state.copyWith(isResending: true));
      onForgetPassword(resendOtp: true);
    } else {
      showToast(
          "Please wait ${phoneHelper.getFormattedTime()} before resending");
    }
  }

  void onForgetPassword({bool resendOtp = false}) {
    if (email.isEmpty) {
      showToast("Please enter email");
      return;
    }
    if (!resendOtp) emit(state.copyWith(isLoading: true));
    authRepository.forgetPassword(email: email).then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
              showToast(error);
            },
            (success) {
              emit(state.copyWith(isLoading: false));
              if (!resendOtp) {
                AppNavigation.pushReplacement(RouteName.verifyOtp,
                    arguments: {"isRegister": false});
              } else {
                phoneHelper.resendCode();
              }
              showToast("OTP sent successfully");
            },
          ),
        );
  }

  void onResetPassword() {
    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      showToast("Please enter new password and confirm password");
      return;
    }
    if (newPassword != confirmNewPassword) {
      showToast("New password and confirm password does not match");
      return;
    }
    final otp = phoneHelper.getOtp();
    emit(state.copyWith(isLoading: true));
    authRepository
        .resetPassword(email: email, otp: otp, newPassword: newPassword)
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (success) {
              emit(state.copyWith(isLoading: false));
              phoneHelper.clearOtp();
              AppNavigation.pushReplacement(RouteName.bottomBar);
              showToast("Password reset successful");
            },
          ),
        );
  }

  void setEmpty() {
    _timerSubscription?.cancel();
    phoneHelper.dispose();
    emit(RegisterScreenState.empty());
  }
}
