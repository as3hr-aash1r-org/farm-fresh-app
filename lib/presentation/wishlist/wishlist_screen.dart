import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import '../cart/cart_cubit.dart';
import 'components/wishlist_book_container.dart';
import 'wishlist_cubit.dart';
import 'wishlist_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  static final cubit = sl<WishlistCubit>();
  static final cartCubit = sl<CartCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text("Your Wishlist"),
          ),
          body: state.books.isEmpty
              ? const Center(child: Text('Your wishlist is empty!'))
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 16),
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return WishlistBookContainer(
                      book: book,
                      onRemoveTap: () => cubit.removeBookFromWishlist(book),
                      onTap: () =>
                          cartCubit.cartNavigator.navigateToBookDetail(book),
                    );
                  },
                ),
        );
      },
    );
  }
}
