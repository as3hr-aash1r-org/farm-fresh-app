import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class ProductDetailsState {
  final ProductModel book;

  ProductDetailsState({required this.book});

  factory ProductDetailsState.empty() =>
      ProductDetailsState(book: ProductModel());

  ProductDetailsState copyWith({ProductModel? book}) =>
      ProductDetailsState(book: book ?? this.book);
}
