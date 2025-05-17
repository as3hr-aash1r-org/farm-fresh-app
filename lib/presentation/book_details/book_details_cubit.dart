import 'package:bloc/bloc.dart';
import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/presentation/book_details/book_details_navigator.dart';
import 'package:farm_fresh_shop_app/presentation/book_details/book_details_state.dart';
import 'package:farm_fresh_shop_app/presentation/wishlist/wishlist_cubit.dart';

import '../../di/service_locator.dart';
import '../cart/cart_cubit.dart';

class BookDetailsCubit extends Cubit<BookDetailsState> {
  final BookEntity params;
  final BookDetailNavigator navigator;
  BookDetailsCubit(this.params, this.navigator)
      : super(BookDetailsState.empty()) {
    setBookDetails();
  }

  void setBookDetails() {
    emit(state.copyWith(book: params));
  }

  void onAddToWishlistTap() {
    final wishListCubit = sl<WishlistCubit>();
    if (wishListCubit.state.books.contains(params)) {
      wishListCubit.removeBookFromWishlist(params);
      showToast('Book removed from wishlist');
    } else {
      wishListCubit.addBookToWishlist(params);
      showToast('Book added to wishlist');
    }
    emit(state.copyWith(book: params));
  }

  void onAddToCartTap() {
    final cartCubit = sl<CartCubit>();
    if (cartCubit.state.books.contains(params)) {
      showToast('Book already in cart');
      return;
    }
    cartCubit.addBookToCart(params);
    showToast('Book added to cart');
  }
}
