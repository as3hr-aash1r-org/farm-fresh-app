import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/utils.dart';
import '../../../initializer.dart';
import '../../cart/cart_cubit.dart';
import '../../cart/cart_state.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = sl<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: homeCubit,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    if (state.isGuestMode) {
                      showConfirmationDialog(
                        "Please login to continue",
                        onYes: () async {
                          await Initializer.dispose();
                        },
                        noText: "Cancel",
                        yesText: "Login",
                      );
                      return;
                    } else {
                      AppNavigation.push(RouteName.profile);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: AppColor.primary,
                      size: 28,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: Text(
                    state.isGuestMode
                        ? "Welcome, Guest!"
                        : 'Welcome, ${state.user.userName}!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
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
            const SizedBox(height: 15),
            SizedBox(
              width: 150,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () async {
                    // final cartCubit = sl<CartCubit>();
                    // final homeCubit = sl<HomeCubit>();
                    // final currentDeliveryType =
                    //     homeCubit.state.selectedDeliveryType;

                    // final hasCartItems =
                    //     cartCubit.state.products.isNotEmpty;

                    // bool shouldProceed = true;

                    // if (currentDeliveryType != DeliveryType.none &&
                    //     hasCartItems) {
                    //   shouldProceed = await showConfirmationDialog(
                    //     "Changing the delivery type will clear your cart. Do you want to continue?",
                    //   );
                    //   if (shouldProceed) {
                    //     cartCubit.clearCart();
                    //   }
                    // }

                    // if (shouldProceed) {
                    //   showDialog(
                    //     context: context,
                    //     builder: (_) => const DeliveryTypeDialog(),
                    //   );
                    // }
                  },
                  child: Center(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(2),
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColor.darkBlue,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Delivery Type:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Pickup",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
