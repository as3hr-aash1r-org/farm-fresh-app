import 'package:farm_fresh_shop_app/data/app_data/app_data.dart';
import 'package:farm_fresh_shop_app/data/model/order_model.dart';
import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../initializer.dart';
import '../../navigation/app_navigation.dart';
import '../home/home_cubit.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final appData = FarmFreshAppData();
  CartCubit() : super(CartState.empty());

  void addMangoToCart(ProductModel product) {
    final existingIndex = state.products.indexWhere((b) => b.id == product.id);
    if (existingIndex == -1) {
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
      removeProductFromCart(product);
      return;
    }
    final updatedProducts = state.products
        .map((b) {
          if (b.id == product.id && b.quantity > 1) {
            return b.copyWith(quantity: b.quantity - 1);
          }
          return b;
        })
        .cast<ProductModel>()
        .toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void removeProductFromCart(ProductModel product) {
    final updatedProducts =
        state.products.where((b) => b.id != product.id).toList();
    emit(state.copyWith(products: updatedProducts));
  }

  void clearCart() {
    emit(CartState.empty());
  }

  double get totalPrice =>
      state.products.fold(0.0, (sum, product) => sum + (product.price ?? 0.0));

  void placeOrder() {
    final homeState = sl<HomeCubit>().state;
    final order = OrderModel(
      paymentId: "32131",
      deliveryType: homeState.selectedDeliveryType.name.toLowerCase(),
      shippingState: homeState.selectedState,
      shippingZipCode: homeState.zipCode,
      airportName: homeState.selectedAirport,
      items: state.products
          .map((product) => OrderItem(
                productId: product.id!,
                quantity: product.quantity,
                totalPrice: product.price!,
              ))
          .toList(),
    );
    emit(state.copyWith(isLoading: true));
    appData.createOrder(order: order).then((response) => response.fold((l) {
          emit(state.copyWith(isLoading: false));
          showToast(l);
        }, (r) {
          AppNavigation.pushReplacement(RouteName.successOrder, arguments: {
            "amount": totalPrice,
          });
        }));
  }
}
