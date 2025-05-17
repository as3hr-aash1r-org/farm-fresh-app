import 'package:farm_fresh_shop_app/presentation/wishlist/wishlist_screen.dart';

import '../../home/home_screen.dart';
import 'package:flutter/material.dart';
import '../../../helpers/styles/app_images.dart';

class BottomBarItem {
  Widget page;
  String image;

  BottomBarItem({
    required this.image,
    required this.page,
  });

  static final appItems = [
    BottomBarItem(
      image: AppImages.home,
      page: const HomeScreen(),
    ),
    BottomBarItem(
      image: AppImages.bookmark,
      page: const WishlistScreen(),
    ),
  ];
}
