import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class CartState {
  final List<ProductModel> products;

  CartState({
    required this.products,
  });

  factory CartState.empty() => CartState(products: []);

  CartState copyWith({
    List<ProductModel>? products,
  }) {
    return CartState(
      products: products ?? this.products,
    );
  }
}
