import 'package:farm_fresh_shop_app/data/model/user_model.dart';

class ProfileState {
  bool isLoading;
  bool changePasswordLoading;
  bool deleteAccountLoading;
  UserModel user;

  ProfileState({
    this.isLoading = false,
    this.changePasswordLoading = false,
    this.deleteAccountLoading = false,
    required this.user,
  });

  factory ProfileState.empty() => ProfileState(user: UserModel());

  ProfileState copyWith({
    bool? isLoading,
    UserModel? user,
    bool? changePasswordLoading,
    bool? deleteAccountLoading,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      deleteAccountLoading: deleteAccountLoading ?? this.deleteAccountLoading,
      user: user ?? this.user,
      changePasswordLoading:
          changePasswordLoading ?? this.changePasswordLoading,
    );
  }
}
