import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../initializer.dart';
import '../../cart/cart_cubit.dart';
import '../../cart/cart_state.dart';
import '../home_cubit.dart';
import '../home_state.dart';
import 'delivery_type_dialog.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  static final homeCubit = sl<HomeCubit>();

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
                    bloc: sl<CartCubit>(),
                    builder: (context, state) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            AppImages.cart,
                            width: 28,
                            scale: 0.2,
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
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: DropdownButtonFormField<DeliveryType>(
                      value: state.selectedDeliveryType == DeliveryType.none
                          ? null
                          : state.selectedDeliveryType,
                      hint: const Text("Select delivery type"),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: DeliveryType.pickup,
                          child: Text("Pickup"),
                        ),
                        DropdownMenuItem(
                          value: DeliveryType.doorstep,
                          child: Text("Doorstep"),
                        ),
                      ],
                      onChanged: (value) {
                        showDialog(
                          context: context,
                          builder: (_) => const DeliveryTypeDialog(),
                        );
                      },
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
            const SizedBox(height: 5),
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
