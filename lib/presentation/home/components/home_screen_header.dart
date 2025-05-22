import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../../cart/cart_cubit.dart';
import '../../cart/cart_state.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final homeCubit = context.read<HomeCubit>();
        final cartCubit = context.read<CartCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome, ${state.user.userName}!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    AppNavigation.push(RouteName.cart);
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
                                state.products.length.toString(),
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
              onChanged: (query) => homeCubit.searchProducts(query),
            ),
          ],
        );
      },
    );
  }
}
