import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/presentation/book_details/book_details_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/book_details/book_details_state.dart';
import 'package:farm_fresh_shop_app/presentation/book_details/components/book_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/service_locator.dart';
import '../wishlist/wishlist_cubit.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.cubit});
  final BookDetailsCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookDetailsCubit, BookDetailsState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new),
                  onPressed: () => Navigator.pop(context),
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    icon:
                        (sl<WishlistCubit>().state.books.contains(cubit.params))
                            ? Image.asset(AppImages.bookmark2)
                            : Image.asset(
                                AppImages.bookmark,
                                color: Colors.white,
                              ),
                    onPressed: () {
                      cubit.onAddToWishlistTap();
                    },
                    color:
                        (sl<WishlistCubit>().state.books.contains(cubit.params))
                            ? AppColor.primary
                            : Colors.white,
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    state.book.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: BookDetailsBody(cubit: cubit)),
            ],
          ),
        );
      },
    );
  }
}
