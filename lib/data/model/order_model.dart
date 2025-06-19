import '../../helpers/utils.dart';

class OrderModel {
  String orderNumber;
  double amount;
  String? deliveryType;
  String? shippingState;
  String? shippingZipCode;
  String? airportName;
  String? status;
  List<OrderItem> items;

  OrderModel({
    required this.amount,
    required this.items,
    this.deliveryType,
    this.orderNumber = "",
    this.status = "",
    this.shippingState,
    this.shippingZipCode,
    this.airportName,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderNumber: json["order_number"],
        amount: json["total_amount"],
        deliveryType: json["delivery_type"],
        shippingState: json["shipping_state"],
        shippingZipCode: json["shipping_zip"],
        airportName: json["airport_name"],
        status: json["status"],
        items: parseList(json["items"], (item) => OrderItem.fromJson(item)),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        if (airportName != null) "airport_name": airportName,
        "items": items.map((e) => e.toJson()).toList(),
      };
}

class OrderItem {
  int productId;
  int quantity;
  double unitPrice;
  double totalPrice;
  String type;
  OrderItem({
    this.unitPrice = 0.0,
    this.type = "",
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        productId: json["product_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        totalPrice: json["total_price"],
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "type": type,
        "quantity": quantity,
        "total_price": totalPrice.toInt()
      };
}
