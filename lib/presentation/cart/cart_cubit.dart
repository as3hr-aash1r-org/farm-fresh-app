import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_state.dart';
import 'cart_navigator.dart';

class CartCubit extends Cubit<CartState> {
  final CartNavigator cartNavigator;
  CartCubit(this.cartNavigator) : super(CartState.empty());

  void addBookToCart(BookEntity book) {
    final existingIndex = state.books.indexWhere((b) => b.title == book.title);
    if (existingIndex != -1) {
      final updatedBooks = List<BookEntity>.from(state.books);
      final updatedBook = updatedBooks[existingIndex].copyWith(
        quantity: updatedBooks[existingIndex].quantity + 1,
      );
      updatedBooks[existingIndex] = updatedBook;
      emit(state.copyWith(books: updatedBooks));
    } else {
      emit(state.copyWith(books: [...state.books, book]));
    }
  }

  void increaseQuantity(BookEntity book) {
    final updatedBooks = state.books.map((b) {
      if (b.title == book.title) {
        return b.copyWith(quantity: b.quantity + 1);
      }
      return b;
    }).toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void decreaseQuantity(BookEntity book) {
    if (book.quantity == 1) {
      removeBookFromCart(book);
      return;
    }
    final updatedBooks = state.books.map((b) {
      if (b.title == book.title && b.quantity > 1) {
        return b.copyWith(quantity: b.quantity - 1);
      }
      return b;
    }).toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void removeBookFromCart(BookEntity book) {
    final updatedBooks =
        state.books.where((b) => b.title != book.title).toList();
    emit(state.copyWith(books: updatedBooks));
  }

  void clearCart() {
    emit(CartState.empty());
  }

  double get totalPrice => state.books
      .fold(0.0, (sum, book) => sum + (book.price ?? 0.0) * book.quantity);
}
