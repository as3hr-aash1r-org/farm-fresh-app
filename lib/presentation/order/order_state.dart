import 'package:farm_fresh_shop_app/data/model/order_model.dart';

class OrderState {
  List<OrderModel> orders;
  bool isLoading;

  OrderState({
    this.isLoading = false,
    required this.orders,
  });

  factory OrderState.initial() {
    return OrderState(orders: []);
  }

  OrderState copyWith({
    bool? isLoading,
    List<OrderModel>? orders,
  }) {
    return OrderState(
      isLoading: isLoading ?? this.isLoading,
      orders: orders ?? this.orders,
    );
  }
}
