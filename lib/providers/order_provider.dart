import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_item.dart';
import '../models/order.dart';
import '../models/user.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];
  final Uuid _uuid = const Uuid();

  List<Order> get orders => [..._orders];

  void addOrder(User user, List<CartItem> cartItems, double totalAmount) {
    _orders.insert(
      0,
      Order(
        id: _uuid.v4(),
        user: user,
        items: cartItems,
        totalAmount: totalAmount,
        orderDate: DateTime.now(),
        status: 'Pending',
      ),
    );
    notifyListeners();
  }

  // In a real app, this would fetch orders from an API
  Future<void> fetchOrders(User user) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For now, we're just using dummy data
    // In a real app, this would be fetched from an API
    notifyListeners();
  }
}
