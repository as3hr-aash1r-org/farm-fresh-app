import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../di/service_locator.dart';
import '../../../../../helpers/styles/app_color.dart';
import '../../../cart_cubit.dart';
import '../../../cart_state.dart';

class CheckoutBody extends StatelessWidget {
  const CheckoutBody({super.key});

  static final cartCubit = sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      bloc: cartCubit,
      builder: (context, state) {
        return Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: cartCubit.state.books.length,
            itemBuilder: (context, index) {
              final book = cartCubit.state.books[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        book.image ?? 'assets/default_book.png',
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                book.title ?? 'Unknown Title',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Spacer(),
                              Text(
                                "x${book.quantity}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "\$${book.price?.toStringAsFixed(2) ?? '0.00'}",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColor.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
