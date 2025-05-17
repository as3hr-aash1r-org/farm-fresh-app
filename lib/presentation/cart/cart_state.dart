import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class CartState {
  final List<ProductModel> books;

  CartState({
    required this.books,
  });

  factory CartState.empty() => CartState(books: []);

  CartState copyWith({
    List<ProductModel>? books,
  }) {
    return CartState(
      books: books ?? this.books,
    );
  }
}
