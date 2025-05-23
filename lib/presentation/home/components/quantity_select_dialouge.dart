// QuantitySelectorDialog.dart
import 'package:flutter/material.dart';
import '../../../data/model/product_json.dart';
import '../../../helpers/styles/app_color.dart';
import '../../../initializer.dart';
import '../../cart/cart_cubit.dart';
import '../home_cubit.dart';
import '../home_state.dart';

class QuantitySelectorDialog extends StatefulWidget {
  final ProductModel product;
  const QuantitySelectorDialog({super.key, required this.product});

  @override
  State<QuantitySelectorDialog> createState() => _QuantitySelectorDialogState();
}

class _QuantitySelectorDialogState extends State<QuantitySelectorDialog> {
  String? selectedQuantity;
  bool isLoading = false;

  List<String> getQuantities(DeliveryType type) {
    if (type == DeliveryType.pickup) {
      return ['8', '12', '16', '20', '24'];
    } else {
      return ['2', '4'];
    }
  }

  void calculatePriceAndAddToCart() async {
    if (selectedQuantity == null) return;

    setState(() => isLoading = true);

    final deliveryType = sl<HomeCubit>().state.selectedDeliveryType;
    final mangoType = widget.product.name ?? 'chaunsa';

    final result = await sl<HomeCubit>().appData.getProductPriceCalculation(
          deliveryType: deliveryType.name.toLowerCase(),
          mangoType: mangoType,
          quantity: selectedQuantity!,
          state: sl<HomeCubit>().state.selectedState,
        );

    setState(() => isLoading = false);

    result.fold(
      (error) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      ),
      (price) {
        final updatedProduct = widget.product.copyWith(price: price.toDouble());
        sl<CartCubit>().addMangoToCart(updatedProduct);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final deliveryType = sl<HomeCubit>().state.selectedDeliveryType;
    final quantities = getQuantities(deliveryType);

    return AlertDialog(
      title: const Text("Select Quantity (Boxes)"),
      content: isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColor.primary))
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: quantities
                  .map(
                    (q) => RadioListTile<String>(
                      value: q,
                      groupValue: selectedQuantity,
                      title: Text("$q boxes"),
                      activeColor: AppColor.primary,
                      onChanged: (val) =>
                          setState(() => selectedQuantity = val),
                    ),
                  )
                  .toList(),
            ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: selectedQuantity == null || isLoading
              ? null
              : calculatePriceAndAddToCart,
          style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary),
          child: const Text("Add to Cart"),
        ),
      ],
    );
  }
}
