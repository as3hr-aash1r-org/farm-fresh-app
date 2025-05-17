import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/service_locator.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../../cart/cart_cubit.dart';
import '../../cart/cart_state.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  static final homeCubit = sl<HomeCubit>();
  static final cartCubit = sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Welcome back, Bunny!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    homeCubit.navigator.navigateToCart();
                  },
                  child: BlocBuilder<CartCubit, CartState>(
                    bloc: cartCubit,
                    builder: (context, state) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            AppImages.cart,
                            width: 24,
                            color: AppColor.primary,
                          ),
                          Positioned(
                            right: -5,
                            top: -10,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: AppColor.primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                state.books.length.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(width: 5),
              ],
            ),
            const Text(
              'What do you want to\nread today?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              onChanged: (query) => homeCubit.searchBooks(query),
            ),
          ],
        );
      },
    );
  }
}
