import 'package:farm_fresh_shop_app/data/model/product_json.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart'
    show AppColor;
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/helpers/utils.dart';
import 'package:farm_fresh_shop_app/helpers/widgets/farm_fresh_asset.dart';
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
    final cardColor = getRandomMangoColor;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  cardColor.withOpacity(0.05),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: cardColor.withOpacity(0.2),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ],
              border: Border.all(
                color: cardColor.withOpacity(0.3),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enhanced image section
                AspectRatio(
                  aspectRatio: 1.2,
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(18)),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            cardColor.withOpacity(0.3),
                            cardColor.withOpacity(0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Product image
                          Center(
                            child: Container(
                              width: double.maxFinite,
                              height: double.maxFinite,
                              color: Colors.white,
                              padding: const EdgeInsets.all(16),
                              child: FarmFreshAsset(
                                image: product.image ?? AppImages.chaunsa,
                                svg: false,
                              ),
                            ),
                          ),
                          // Fresh badge
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: isOutOfStock
                                      ? [
                                          Colors.redAccent,
                                          Colors.red[700]!,
                                        ]
                                      : [
                                          AppColor.primary,
                                          AppColor.green,
                                        ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primary.withOpacity(0.3),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                isOutOfStock ? "🚫 OUT OF STOCK" : "🥭 FRESH",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Product name with enhanced styling
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(
                    product.name ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: AppColor.green,
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                // Price and cart section with enhanced design
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Enhanced price display
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColor.lightYellow.withOpacity(0.3),
                              AppColor.peach.withOpacity(0.2),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColor.orange.withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          "\$${product.price?.toStringAsFixed(2) ?? '0.00'}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppColor.orange,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: isOutOfStock
                            ? null
                            : () async {
                                if (await isGuestMode) {
                                  showConfirmationDialog(
                                    "Please login to add to cart",
                                    onYes: () async {
                                      await Initializer.dispose();
                                    },
                                    noText: "Cancel",
                                    yesText: "Login",
                                  );
                                  return;
                                }
                                final homeState = sl<HomeCubit>().state;
                                final deliveryType =
                                    homeState.selectedDeliveryType;
                                if (deliveryType == DeliveryType.pickup &&
                                    homeState.selectedAirport == null) {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => const DeliveryTypeDialog(),
                                  );
                                } else {
                                  await showDialog(
                                    context: context,
                                    builder: (_) => QuantitySelectorDialog(
                                        product: product),
                                  );
                                }
                              },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: isOutOfStock
                                ? LinearGradient(
                                    colors: [
                                      Colors.grey[300]!,
                                      Colors.grey[400]!,
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      AppColor.primary,
                                      AppColor.green,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: isOutOfStock
                                ? null
                                : [
                                    BoxShadow(
                                      color: AppColor.primary.withOpacity(0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                          ),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
