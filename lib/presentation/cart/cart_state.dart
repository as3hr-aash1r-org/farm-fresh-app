import 'package:farm_fresh_shop_app/data/model/product_json.dart';

class CartState {
  final List<ProductModel> products;
  bool isLoading;

  CartState({
    this.isLoading = false,
    required this.products,
  });

  factory CartState.empty() => CartState(products: []);

  CartState copyWith({
    bool? isLoading,
    List<ProductModel>? products,
  }) {
    return CartState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
    );
  }
}
