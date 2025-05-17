import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/presentation/wishlist/wishlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit() : super(WishlistState.empty());

  void addBookToWishlist(ProductModel book) {
    state.books.insert(0, book);
    emit(state.copyWith(books: state.books));
  }

  void removeBookFromWishlist(ProductModel book) {
    state.books.remove(book);
    emit(state.copyWith(books: state.books));
  }
}
