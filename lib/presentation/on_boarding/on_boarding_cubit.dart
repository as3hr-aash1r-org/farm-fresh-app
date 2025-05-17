import 'package:farm_fresh_shop_app/di/initializer.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:farm_fresh_shop_app/presentation/on_boarding/on_boarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingState.empty());

  void onGetInPressed() {
    localStorageRepository.getValue("token").then(
          (response) => response.fold(
            (error) => AppNavigation.pushReplacement(RouteName.login),
            (token) => AppNavigation.pushReplacement(RouteName.login),
          ),
        );
  }
}
