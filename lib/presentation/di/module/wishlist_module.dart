import '../../../di/service_locator.dart';
import '../../wishlist/wishlist_cubit.dart';

class WishListModule {
  static Future<void> configureWishListModuleInjection() async {
    sl.registerLazySingleton<WishlistCubit>(() => WishlistCubit());
  }
}
