import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/helpers/widgets/farm_fresh_asset.dart';
import 'package:farm_fresh_shop_app/presentation/cart/cart_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/home/home_cubit.dart';
import 'package:flutter/material.dart';
import '../../../initializer.dart';
import '../home_state.dart';
import 'delivery_type_dialog.dart';
import 'quantity_select_dialouge.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final isOutOfStock = (product.inStock ?? 0) == 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Container(
                      color: getRandomMangoColor,
                      child: Center(
                        child: FarmFreshAsset(
                          image: product.image ?? AppImages.mango1,
                          svg: false,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Text(
                    product.name ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price?.toStringAsFixed(2) ?? '0.00'}/box",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: isOutOfStock
                            ? null
                            : () async {
                                final deliveryType =
                                    sl<HomeCubit>().state.selectedDeliveryType;
                                if (deliveryType == DeliveryType.none) {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => const DeliveryTypeDialog(),
                                  );
                                } else {
                                  final cartCubit = sl<CartCubit>();
                                  final existingIndex = cartCubit.state.products
                                      .indexWhere((b) => b.id == product.id);
                                  print(existingIndex);
                                  if (existingIndex != -1) {
                                    showToast("Product already added to cart");
                                    return;
                                  } else {
                                    await showDialog(
                                      context: context,
                                      builder: (_) => QuantitySelectorDialog(
                                          product: product),
                                    );
                                  }
                                }
                              },
                        child: Icon(
                          Icons.shopping_basket,
                          color: isOutOfStock ? Colors.grey : Colors.green,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          if (isOutOfStock)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Out of Stock",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
