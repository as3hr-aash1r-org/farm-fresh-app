import 'package:farm_fresh_shop_app/data/app_data/app_data.dart';
import 'package:farm_fresh_shop_app/presentation/order/order_state.dart'
    show OrderState;
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final appData = FarmFreshAppData();
  OrderCubit() : super(OrderState.initial()) {
    fetchOrders();
  }

  fetchOrders() {
    emit(state.copyWith(isLoading: true));
    appData.getOrders().then(
          (response) => response.fold(
            (error) {
              emit(state.copyWith(isLoading: false));
            },
            (orders) {
              emit(state.copyWith(orders: orders, isLoading: false));
            },
          ),
        );
  }
}
