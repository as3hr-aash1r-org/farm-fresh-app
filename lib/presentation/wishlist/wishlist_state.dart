import '../../domain/entities/book_entity.dart';

class WishlistState {
  final List<BookEntity> books;

  WishlistState({
    required this.books,
  });

  factory WishlistState.empty() => WishlistState(books: []);

  WishlistState copyWith({
    List<BookEntity>? books,
  }) {
    return WishlistState(
      books: books ?? this.books,
    );
  }
}
