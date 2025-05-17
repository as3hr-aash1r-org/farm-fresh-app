import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void addBookToCart(ProductModel book) {
    final existingIndex = state.books.indexWhere((b) => b.name == book.name);
    if (existingIndex != -1) {
      final updatedBooks = List<ProductModel>.from(state.books);
      final updatedBook = updatedBooks[existingIndex].copyWith(
        quantity: updatedBooks[existingIndex].quantity + 1,
      );
      updatedBooks[existingIndex] = updatedBook;
      emit(state.copyWith(books: updatedBooks));
    } else {
      emit(state.copyWith(books: [...state.books, book]));
    }
  }

  void increaseQuantity(ProductModel book) {
    final updatedBooks = state.books
        .map((b) {
          if (b.name == book.name) {
            return b.copyWith(quantity: b.quantity + 1);
          }
          return b;
        })
        .cast<ProductModel>()
        .toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void decreaseQuantity(ProductModel book) {
    if (book.quantity == 1) {
      removeBookFromCart(book);
      return;
    }
    final updatedBooks = state.books
        .map((b) {
          if (b.name == book.name && b.quantity > 1) {
            return b.copyWith(quantity: b.quantity - 1);
          }
          return b;
        })
        .cast<ProductModel>()
        .toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void removeBookFromCart(ProductModel book) {
    final updatedBooks = state.books.where((b) => b.name != book.name).toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void clearCart() {
    emit(CartState.empty());
  }

  double get totalPrice => state.books
      .fold(0.0, (sum, book) => sum + (book.price ?? 0.0) * book.quantity);
}
