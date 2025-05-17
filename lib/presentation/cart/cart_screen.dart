import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import 'components/cart_book_container.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static final cartCubit = sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: cartCubit,
      builder: (context, state) {
        final totalPrice = cartCubit.totalPrice;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Your Cart"),
          ),
          body: state.books.isEmpty
              ? const Center(child: Text('Your Cart is empty!'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          final book = state.books[index];
                          return CartBookContainer(
                            book: book,
                            onRemoveTap: () =>
                                cartCubit.removeBookFromCart(book),
                            onIncrease: () => cartCubit.increaseQuantity(book),
                            onDecrease: () => cartCubit.decreaseQuantity(book),
                            onTap: () => cartCubit.cartNavigator
                                .navigateToBookDetail(book),
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Total: \$${totalPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: AppColor.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              cartCubit.cartNavigator.openCheckOut();
                            },
                            child: const Text(
                              "Proceed to Checkout",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
