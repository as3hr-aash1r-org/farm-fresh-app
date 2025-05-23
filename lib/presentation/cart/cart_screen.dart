import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../initializer.dart';
import 'components/cart_product_container.dart';
import 'cart_cubit.dart';
import 'cart_state.dart';
import 'components/payment/payment_sheet.dart' show PaymentBottomSheet;

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
          body: state.products.isEmpty
              ? const Center(child: Text('Your Cart is empty!'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return CartProductContainer(
                            product: product,
                            onRemoveTap: () =>
                                cartCubit.removeProductFromCart(product),
                            onIncrease: () =>
                                cartCubit.increaseQuantity(product),
                            onDecrease: () =>
                                cartCubit.decreaseQuantity(product),
                            onTap: () {},
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
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) => PaymentBottomSheet(
                                  totalAmount: cartCubit.totalPrice,
                                  onPaymentSuccess: (payment) {
                                    print('Payment completed successfully!');
                                    cartCubit.placeOrder(payment);
                                  },
                                ),
                              );
                            },
                            child: state.isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white)
                                : const Text(
                                    "Place Order",
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
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
