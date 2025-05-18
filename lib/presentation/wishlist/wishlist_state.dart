import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class WishlistState {
  final List<ProductModel> products;

  WishlistState({
    required this.products,
  });

  factory WishlistState.empty() => WishlistState(products: []);

  WishlistState copyWith({
    List<ProductModel>? products,
  }) {
    return WishlistState(
      products: products ?? this.products,
    );
  }
}
