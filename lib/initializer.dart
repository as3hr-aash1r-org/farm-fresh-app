import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/register_screen_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/cart/cart_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/order/order_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_cubit.dart';
import 'package:get_it/get_it.dart';

import 'data/local_storage/local_storage_repository.dart';
import 'network/network_repository.dart';

final networkRepository = NetworkRepository();
final localStorageRepository = LocalStorageRepository();
final sl = GetIt.instance;
Future<bool> get isGuestMode => localStorageRepository
    .getValue("token")
    .then((response) => response.fold((error) => true, (token) => false));

class Initializer {
  static Future<void> init() async {
    sl.registerLazySingleton<CartCubit>(() => CartCubit());
    sl.registerLazySingleton<ProfileCubit>(() => ProfileCubit());
    sl.registerLazySingleton<RegisterScreenCubit>(() => RegisterScreenCubit());
    sl.registerLazySingleton<HomeCubit>(() => HomeCubit());
    sl.registerLazySingleton<OrderCubit>(() => OrderCubit());
  }

  static Future<void> dispose() async {
    await sl.reset(dispose: true);
    init();
    localStorageRepository.deleteValue("token");
    localStorageRepository.deleteValue("user");
    AppNavigation.pushAndRemoveUntil(RouteName.login);
  }
}
