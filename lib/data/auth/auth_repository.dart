import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:farm_fresh_shop_app/initializer.dart';
import '../model/user_model.dart';

class AuthRepository {
  Future<Either<String, UserModel>> login(String email, String password) async {
    var formData = FormData.fromMap({
      "username": email,
      "password": password,
    });

    final response =
        await networkRepository.post(url: "/auth/login", data: formData);

    if (!response.failed) {
      final data = response.data;
      if (data["user"] == null) {
        return left("Otp Sent");
      }
      localStorageRepository.setValue("user", jsonEncode(data["user"]));
      return right(UserModel.fromJson(data["user"]));
    }

    return left(response.message);
  }

  Future<Either<String, bool>> register(
      String email, String password, String username) async {
    final response = await networkRepository.post(url: "/auth/register", data: {
      "email": email,
      "password": password,
      "username": username,
      "is_admin": "false"
    });
    if (!response.failed) {
      return right(true);
    }

    return left(response.message);
  }

  Future<Either<String, bool>> forgetPassword({required String email}) async {
    final response =
        await networkRepository.post(url: "/auth/forgot-password", data: {
      "email": email,
    });
    if (!response.failed) {
      return right(true);
    }

    return left(response.message);
  }

  Future<Either<String, bool>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    final response =
        await networkRepository.post(url: "/auth/reset-password", data: {
      "email": email,
      "otp": otp,
      "new_password": newPassword,
    });
    if (!response.failed) {
      return right(true);
    }

    return left(response.message);
  }

  Future<Either<String, UserModel>> verifyOtp({
    required String email,
    required String otp,
  }) async {
    final response =
        await networkRepository.post(url: "/auth/verify-otp", data: {
      "email": email,
      "otp": otp,
    });
    if (!response.failed) {
      final data = response.data;
      localStorageRepository.setValue("user", jsonEncode(data["user"]));
      return right(UserModel.fromJson(data["user"]));
    }

    return left(response.message);
  }

  Future<Either<String, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final response = await networkRepository.post(
        url: "/auth/change-password",
        data: {"old_password": oldPassword, "new_password": newPassword});
    if (!response.failed) {
      return right(true);
    }

    return left(response.message);
  }

  Future<Either<String, bool>> deleteAccount() async {
    final response =
        await networkRepository.delete(url: "/auth/delete-account");
    if (!response.failed) {
      return right(true);
    }

    return left(response.message);
  }
}
