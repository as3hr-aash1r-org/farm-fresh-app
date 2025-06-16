import 'package:farm_fresh_shop_app/data/model/order_model.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'payment/webview_checkout.dart';

class PaymentBottomSheet extends StatefulWidget {
  final double totalAmount;
  final String email;
  final String? airportName;
  final String? state;
  final String? stateZip;
  final void Function(PaymentModel payment)? onPaymentSuccess;

  const PaymentBottomSheet({
    Key? key,
    required this.totalAmount,
    required this.email,
    this.airportName,
    this.state,
    this.stateZip,
    this.onPaymentSuccess,
  }) : super(key: key);

  @override
  State<PaymentBottomSheet> createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  // ... keep all other fields and methods ...

  // Replace _processPayment to launch WebView
  void _processPayment() async {
    if (widget.totalAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Amount must be greater than zero.')),
      );
      return;
    }

    // TODO: Replace with real token from user auth
    final userToken = 'DUMMY_USER_TOKEN';

    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => WebviewCheckoutPage(
          amount: widget.totalAmount,
          token: userToken,
        ),
      ),
    );

    if (result != null && result is String && result.contains('success')) {
      // TODO: Call onPaymentSuccess with a dummy PaymentModel or fetch real data
      if (widget.onPaymentSuccess != null) {
        widget.onPaymentSuccess!(PaymentModel());
      }
      Navigator.of(context).pop();
    } else if (result != null && result is String && result.contains('fail')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Payment failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ...rest of your build method remains unchanged...
    return Container(); // Placeholder: Replace with the actual build code from your existing implementation
  }
}
