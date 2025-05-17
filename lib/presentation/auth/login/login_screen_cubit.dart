import 'package:farm_fresh_shop_app/data/auth/auth_repository.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/auth/login/login_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../navigation/app_navigation.dart';
import '../../../navigation/route_name.dart';

class LoginScreenCubit extends Cubit<LoginScreenState> {
  final authRepository = AuthRepository();
  String email = "";
  String password = "";
  LoginScreenCubit() : super(LoginScreenState.empty());

  void onEmailChange(String val) {
    email = val;
  }

  void onPasswordChange(String val) {
    password = val;
  }

  void onLogin() {
    if (email.isEmpty || password.isEmpty) {
      showToast("Please enter email and password");
      return;
    }
    emit(state.copyWith(isLoading: true));
    authRepository.login(email, password).then(
          (response) => response.fold(
            (error) {
              showToast(error);
              emit(state.copyWith(isLoading: false));
            },
            (user) {
              emit(state.copyWith(isLoading: false));
              AppNavigation.pushReplacement(RouteName.bottomBar);
              showToast("Login successful");
            },
          ),
        );
  }
}
