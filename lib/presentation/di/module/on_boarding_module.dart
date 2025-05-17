import '../../../di/service_locator.dart';
import '../../on_boarding/on_boarding_cubit.dart';
import '../../on_boarding/on_boarding_navigator.dart';

class OnBoardingModule {
  static Future<void> configureOnBoardingModuleInjection() async {
    sl.registerLazySingleton<OnBoardingNavigator>(
        () => OnBoardingNavigator(sl()));
    sl.registerLazySingleton<OnBoardingCubit>(() => OnBoardingCubit(sl()));
  }
}
