import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../navigation/route_name.dart';
import 'components/wishlist_book_container.dart';
import 'wishlist_cubit.dart';
import 'wishlist_state.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        final cubit = context.read<WishlistCubit>();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your Wishlist",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              Expanded(
                child: state.books.isEmpty
                    ? const Center(child: Text('Your wishlist is empty!'))
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        itemCount: state.books.length,
                        itemBuilder: (context, index) {
                          final book = state.books[index];
                          return WishlistBookContainer(
                            book: book,
                            onRemoveTap: () =>
                                cubit.removeBookFromWishlist(book),
                            onTap: () => AppNavigation.push(
                                RouteName.bookDetails,
                                arguments: {'book': book}),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
    );
  }
}
