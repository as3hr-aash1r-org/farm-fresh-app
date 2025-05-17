import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

class BookDetailsState {
  final BookEntity book;

  BookDetailsState({required this.book});

  factory BookDetailsState.empty() =>
      BookDetailsState(book: BookEntity.empty());

  BookDetailsState copyWith({BookEntity? book}) =>
      BookDetailsState(book: book ?? this.book);
}
