import '../../domain/entities/book_entity.dart';

class CartState {
  final List<BookEntity> books;

  CartState({
    required this.books,
  });

  factory CartState.empty() => CartState(books: []);

  CartState copyWith({
    List<BookEntity>? books,
  }) {
    return CartState(
      books: books ?? this.books,
    );
  }
}
