import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/presentation/product_details/product_details_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/product_details/product_details_state.dart';
import 'package:farm_fresh_shop_app/presentation/product_details/components/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helpers/styles/app_color.dart';
import '../wishlist/wishlist_cubit.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.book});
  final ProductModel book;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsCubit>(
      create: (context) => ProductDetailsCubit(book),
      child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          final cubit = context.read<ProductDetailsCubit>();
          final wishListCubit = context.read<WishlistCubit>();
          return Scaffold(
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  cubit.onAddToCartTap(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                    'Buy for \$${state.book.price?.toStringAsFixed(2) ?? "14.95"}'),
              ),
            ),
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
                          (wishListCubit.state.products.contains(cubit.params))
                              ? Image.asset(AppImages.bookmark2)
                              : Image.asset(
                                  AppImages.bookmark,
                                  color: Colors.white,
                                ),
                      onPressed: () {
                        cubit.onAddToWishlistTap(context);
                      },
                      color:
                          (wishListCubit.state.products.contains(cubit.params))
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
                SliverToBoxAdapter(child: ProductDetailsBody()),
              ],
            ),
          );
        },
      ),
    );
  }
}
