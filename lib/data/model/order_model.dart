class OrderModel {
  String deliveryType;
  String? shippingState;
  String? shippingZipCode;
  String? airportName;
  String paymentId;
  List<OrderItem> items;

  OrderModel({
    required this.deliveryType,
    required this.paymentId,
    required this.items,
    this.shippingState,
    this.shippingZipCode,
    this.airportName,
  })  : assert(
          deliveryType == "doorstep" || deliveryType == "pickup",
          "Delivery type must be doorstep or pickup",
        ),
        assert(deliveryType == "pickup" ? airportName != null : true,
            "Airport name is required for pickup delivery"),
        assert(
          deliveryType == "doorstep"
              ? shippingState != null && shippingZipCode != null
              : true,
          "Shipping state and zip code are required for doorstep delivery",
        );

  Map<String, dynamic> toJson() => {
        "delivery_type": deliveryType,
        if (shippingState != null) "shipping_state": shippingState,
        if (shippingZipCode != null) "shipping_zip": shippingZipCode,
        if (airportName != null) "airport_name": airportName,
        "payment_id": paymentId,
        "items": items.map((e) => e.toJson()).toList()
      };
}

class OrderItem {
  int productId;
  int quantity;
  double totalPrice;
  OrderItem({
    required this.productId,
    required this.quantity,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "quantity": quantity,
        "total_price": totalPrice.toInt()
      };
}
