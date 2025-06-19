import 'dart:convert';
import 'package:farm_fresh_shop_app/data/auth/auth_repository.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final authRepository = AuthRepository();
  String oldPassword = "";
  String newPassword = "";
  ProfileCubit() : super(ProfileState.empty());

  void getProfile() {
    localStorageRepository
        .getValue("user")
        .then((response) => response.fold((error) {
              emit(state.copyWith(user: null));
            }, (user) {
              emit(state.copyWith(user: UserModel.fromJson(jsonDecode(user))));
            }));
  }

  void logOut() async {
    await Initializer.dispose();
  }

  void changePassword() {
    emit(state.copyWith(changePasswordLoading: true));
    authRepository
        .changePassword(oldPassword: oldPassword, newPassword: newPassword)
        .then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(changePasswordLoading: false));
              showToast(error);
            },
            (success) {
              emit(state.copyWith(changePasswordLoading: false));
              showToast("Password changed successfully");
            },
          ),
        );
  }

  void deleteAccount() {
    emit(state.copyWith(deleteAccountLoading: true));
    authRepository.deleteAccount().then((response) => response.fold((error) {
          emit(state.copyWith(deleteAccountLoading: false));
          showToast(error);
        }, (success) {
          emit(state.copyWith(deleteAccountLoading: false));
          logOut();
        }));
  }

  void setEmpty() => emit(ProfileState.empty());
}
