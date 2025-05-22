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
      localStorageRepository.setValue("user", jsonEncode(data["user"]));
      return right(UserModel.fromJson(data["user"]));
    }

    return left(response.message);
  }

  Future<Either<String, UserModel>> register(
      String email, String password, String username) async {
    final response = await networkRepository.post(url: "/auth/register", data: {
      "email": email,
      "password": password,
      "username": username,
      "is_admin": "false"
    });
    if (!response.failed) {
      final data = response.data;
      localStorageRepository.setValue("user", jsonEncode(data["user"]));
      return right(UserModel.fromJson(data["user"]));
    }

    return left(response.message);
  }
}
