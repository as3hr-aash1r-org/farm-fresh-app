import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../home/home_cubit.dart';
import '../order/order_cubit.dart';
import 'cart_cubit.dart';

class PaymentWebView extends StatefulWidget {
  final String url;
  const PaymentWebView({required this.url});

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    print("URL: ${widget.url}");
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {
    sl<CartCubit>().clearCart();
    sl<HomeCubit>().fetchData();
    sl<OrderCubit>().fetchOrders();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
