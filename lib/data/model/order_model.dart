import '../../helpers/utils.dart';

class OrderModel {
  String orderNumber;
  double amount;
  String deliveryType;
  String? shippingState;
  String? shippingZipCode;
  String? airportName;
  String? status;
  List<OrderItem> items;
  PaymentModel payment;

  OrderModel({
    required this.amount,
    required this.deliveryType,
    required this.items,
    required this.payment,
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
        payment: PaymentModel.empty(),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "delivery_type": deliveryType,
        if (shippingState != null) "shipping_state": shippingState,
        if (shippingZipCode != null) "shipping_zip": shippingZipCode,
        if (airportName != null) "airport_name": airportName,
        "items": items.map((e) => e.toJson()).toList(),
        ...payment.toJson(),
      };
}

class OrderItem {
  int productId;
  int quantity;
  double unitPrice;
  double totalPrice;
  OrderItem({
    this.unitPrice = 0.0,
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
        "quantity": quantity,
        "total_price": totalPrice.toInt()
      };
}

class PaymentModel {
  String firstName;
  String lastName;
  String cvc;
  String cardNumber;
  String expiryDate;

  factory PaymentModel.empty() => PaymentModel(
        firstName: "",
        lastName: "",
        cvc: "",
        cardNumber: "",
        expiryDate: "",
      );

  PaymentModel({
    required this.firstName,
    required this.lastName,
    required this.cvc,
    required this.cardNumber,
    required this.expiryDate,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        // "card_code": cvc,
        // "card_number": cardNumber,
        // "expiration_date": expiryDate
        "card_number": "4111111111111111",
        "expiration_date": "1225",
        "card_code": "123",
      };
}
