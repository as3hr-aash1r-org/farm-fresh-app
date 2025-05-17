import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class BookDetailsState {
  final ProductModel book;

  BookDetailsState({required this.book});

  factory BookDetailsState.empty() => BookDetailsState(book: ProductModel());

  BookDetailsState copyWith({ProductModel? book}) =>
      BookDetailsState(book: book ?? this.book);
}
