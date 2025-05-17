import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class WishlistState {
  final List<ProductModel> books;

  WishlistState({
    required this.books,
  });

  factory WishlistState.empty() => WishlistState(books: []);

  WishlistState copyWith({
    List<ProductModel>? books,
  }) {
    return WishlistState(
      books: books ?? this.books,
    );
  }
}
