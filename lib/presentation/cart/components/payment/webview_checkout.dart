import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewCheckoutPage extends StatefulWidget {
  final double amount;
  final String token;

  const WebviewCheckoutPage({Key? key, required this.amount, required this.token}) : super(key: key);

  @override
  State<WebviewCheckoutPage> createState() => _WebviewCheckoutPageState();
}

class _WebviewCheckoutPageState extends State<WebviewCheckoutPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String? _result;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            // Listen for success/failure callback via special URL scheme
            if (request.url.startsWith('farmfresh://payment/')) {
              setState(() {
                _result = request.url;
              });
              Navigator.of(context).pop(_result);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    _loadCheckout();
  }

  void _loadCheckout() {
    final encodedToken = Uri.encodeComponent(widget.token);
    final url =
        'http://localhost:8000/api/v1/payments/checkout?amount=${widget.amount}&token=$encodedToken';
    _controller.loadRequest(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Checkout')),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
