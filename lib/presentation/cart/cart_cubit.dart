import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.empty());

  void addBookToCart(ProductModel product) {
    final existingIndex =
        state.products.indexWhere((b) => b.name == product.name);
    if (existingIndex != -1) {
      final updatedProducts = List<ProductModel>.from(state.products);
      final updatedBook = updatedProducts[existingIndex].copyWith(
        quantity: updatedProducts[existingIndex].quantity + 1,
      );
      updatedProducts[existingIndex] = updatedBook;
      emit(state.copyWith(products: updatedProducts));
    } else {
      emit(state.copyWith(products: [...state.products, product]));
    }
  }

  void increaseQuantity(ProductModel product) {
    final updatedProducts = state.products
        .map((b) {
          if (b.name == product.name) {
            return b.copyWith(quantity: b.quantity + 1);
          }
          return b;
        })
        .cast<ProductModel>()
        .toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void decreaseQuantity(ProductModel product) {
    if (product.quantity == 1) {
      removeBookFromCart(product);
      return;
    }
    final updatedProducts = state.products
        .map((b) {
          if (b.name == product.name && b.quantity > 1) {
            return b.copyWith(quantity: b.quantity - 1);
          }
          return b;
        })
        .cast<ProductModel>()
        .toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void removeBookFromCart(ProductModel product) {
    final updatedProducts =
        state.products.where((b) => b.name != product.name).toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void clearCart() {
    emit(CartState.empty());
  }

  double get totalPrice => state.products.fold(
      0.0, (sum, product) => sum + (product.price ?? 0.0) * product.quantity);
}
