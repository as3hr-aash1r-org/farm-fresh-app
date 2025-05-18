import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/product_details/product_details_state.dart';
import 'package:farm_fresh_shop_app/presentation/wishlist/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cart/cart_cubit.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductModel params;
  ProductDetailsCubit(this.params) : super(ProductDetailsState.empty()) {
    setBookDetails();
  }

  void setBookDetails() {
    emit(state.copyWith(book: params));
  }

  void onAddToWishlistTap(BuildContext context) {
    final wishListCubit = context.read<WishlistCubit>();
    if (wishListCubit.state.products.contains(params)) {
      wishListCubit.removeBookFromWishlist(params);
      showToast('Book removed from wishlist');
    } else {
      wishListCubit.addBookToWishlist(params);
      showToast('Book added to wishlist');
    }
    emit(state.copyWith(book: params));
  }

  void onAddToCartTap(BuildContext context) {
    final cartCubit = context.read<CartCubit>();
    if (cartCubit.state.products.contains(params)) {
      showToast('Book already in cart');
      return;
    }
    cartCubit.addBookToCart(params);
    showToast('Book added to cart');
  }
}
