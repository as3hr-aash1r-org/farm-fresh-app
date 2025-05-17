import 'package:farm_fresh_shop_app/data/auth/auth_repository.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_screen_state.dart';

class RegisterScreenCubit extends Cubit<RegisterScreenState> {
  final authRepository = AuthRepository();
  String email = "";
  String password = "";
  String username = "";
  RegisterScreenCubit() : super(RegisterScreenState.empty());

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
              AppNavigation.pushReplacement(RouteName.bottomBar);
              showToast("Registration successful");
            },
          ),
        );
  }
}
