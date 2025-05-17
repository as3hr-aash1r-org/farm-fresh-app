import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

class ReadBookState {
  static const double minFontSize = 10.0;
  static const double maxFontSize = 40.0;
  static const double defaultFontSize = 16.0;

  final BookEntity book;
  final double fontSize;

  ReadBookState({required this.book, this.fontSize = defaultFontSize});

  factory ReadBookState.empty() => ReadBookState(book: BookEntity.empty());

  ReadBookState copyWith({BookEntity? book, double? fontSize}) => ReadBookState(
        book: book ?? this.book,
        fontSize: fontSize?.clamp(minFontSize, maxFontSize) ?? this.fontSize,
      );
}
