import 'cart_item.dart';
import 'user.dart';

class Order {
  final String id;
  final User user;
  final List<CartItem> items;
  final double totalAmount;
  final DateTime orderDate;
  final String status;

  Order({
    required this.id,
    required this.user,
    required this.items,
    required this.totalAmount,
    required this.orderDate,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json, User user, List<CartItem> items) {
    return Order(
      id: json['id'],
      user: user,
      items: items,
      totalAmount: json['totalAmount'].toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': user.id,
      'items': items.map((item) => item.toJson()).toList(),
      'totalAmount': totalAmount,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }
}
