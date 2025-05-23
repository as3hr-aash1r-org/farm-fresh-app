import 'package:farm_fresh_shop_app/presentation/cart/cart_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/order/order_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/local_storage/local_storage_repository.dart';
import 'network/network_repository.dart';

final networkRepository = NetworkRepository();
final localStorageRepository = LocalStorageRepository();
final sl = GetIt.instance;

class Initializer {
  static Future<void> init() async {
    sl.registerLazySingleton<CartCubit>(() => CartCubit());
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
    sl.registerLazySingleton<OrderCubit>(() => OrderCubit());
  }

  static Future<void> dispose() async {
    await sl.reset(dispose: true);
    localStorageRepository.deleteValue("token");
    localStorageRepository.deleteValue("user");
  }
}
