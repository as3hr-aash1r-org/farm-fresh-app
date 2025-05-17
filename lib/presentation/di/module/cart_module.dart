import 'package:farm_fresh_shop_app/presentation/cart/cart_navigator.dart';

import '../../../di/service_locator.dart';
import '../../cart/cart_cubit.dart';

class CartModule {
  static Future<void> configureCartModuleInjection() async {
    sl.registerLazySingleton<CartNavigator>(() => CartNavigator(sl()));
    sl.registerLazySingleton<CartCubit>(() => CartCubit(sl()));
  }
}
