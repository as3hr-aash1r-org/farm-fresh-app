import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:farm_fresh_shop_app/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  Future<Either<String, String>> getValue(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final value = prefs.getString(key);
      if (value?.isNotEmpty == true) {
        return right(value!);
      } else {
        return left("Key not found");
      }
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, bool>> setValue(
    String key,
    String value,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value);
      return right(true);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, bool>> deleteValue(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove(key);
      return right(true);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString("user");
    if (user != null) {
      return UserModel.fromJson(jsonDecode(user));
    }
    return UserModel();
  }
}
