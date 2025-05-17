import 'package:farm_fresh_shop_app/presentation/di/module/book_detail_module.dart';
import 'package:farm_fresh_shop_app/presentation/di/module/home_module.dart';
import 'package:farm_fresh_shop_app/presentation/di/module/read_book_module.dart';
import 'package:farm_fresh_shop_app/presentation/di/module/wishlist_module.dart';

import 'module/bottom_bar_module.dart';
import 'module/cart_module.dart';
import 'module/on_boarding_module.dart';

class PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await OnBoardingModule.configureOnBoardingModuleInjection();
    await BottomBarModule.configureBottomBarModuleInjection();
    await HomeModule.configureHomeModuleInjection();
    await BookDetailModule.configureBookDetailModuleInjection();
    await WishListModule.configureWishListModuleInjection();
    await CartModule.configureCartModuleInjection();
    await ReadBookModule.configureReadBookModuleInjection();
  }
}
