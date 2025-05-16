import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatefulWidget {
  final Product product;
  final VoidCallback? onTap;

  const ProductCard({
    Key? key,
    required this.product,
    this.onTap,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    // Initialize quantity from cart if product is already in cart
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      if (cartProvider.items.containsKey(widget.product.id)) {
        setState(() {
          _quantity = cartProvider.items[widget.product.id]!.quantity;
        });
      }
    });
  }

  // Add to cart with current quantity
  void _addToCart() {
    if (_quantity > 0) {
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.updateQuantity(widget.product.id, _quantity);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${widget.product.name} added to cart'),
          duration: const Duration(seconds: 1),
          backgroundColor: AppConstants.primaryColor,
        ),
      );
    }
  }

  // Increment quantity
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
    _addToCart();
  }

  // Decrement quantity
  void _decrementQuantity() {
    if (_quantity > 0) {
      setState(() {
        _quantity--;
      });

      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      if (_quantity == 0) {
        cartProvider.removeItem(widget.product.id);
      } else {
        cartProvider.updateQuantity(widget.product.id, _quantity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Container(
              height: 118,
              width: double.infinity,
              color: Colors.grey.shade100,
              child: widget.product.imageUrl.startsWith('assets')
                  ? Image.asset(
                      widget.product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco,
                          size: 60,
                          color: AppConstants.primaryColor,
                        );
                      },
                    )
                  : Image.network(
                      widget.product.imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.eco,
                          size: 60,
                          color: AppConstants.primaryColor,
                        );
                      },
                    ),
            ),
          ),

          // Product Info
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  widget.product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),

                // Price
                Text(
                  '₹${widget.product.price.toStringAsFixed(2)} / kg',
                  style: const TextStyle(
                    color: AppConstants.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),

                // Stock Status
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: widget.product.inStock
                        ? AppConstants.successColor.withOpacity(0.1)
                        : AppConstants.errorColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    widget.product.inStock ? 'In Stock' : 'Out of Stock',
                    style: TextStyle(
                      color: widget.product.inStock
                          ? AppConstants.successColor
                          : AppConstants.errorColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // Quantity Controls
                if (widget.product.inStock) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Label
                      Text(
                        'Quantity:',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      // Quantity Controls
                      Row(
                        children: [
                          // Decrement Button
                          InkWell(
                            onTap: _decrementQuantity,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: _quantity > 0
                                    ? AppConstants.primaryColor
                                    : Colors.grey.shade300,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 16,
                                color: _quantity > 0
                                    ? Colors.white
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),

                          // Quantity Display
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              _quantity.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),

                          // Increment Button
                          InkWell(
                            onTap: _incrementQuantity,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: AppConstants.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  // Add to Cart Button (only visible when quantity > 0)
                  if (_quantity > 0) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('ADD TO CART'),
                      ),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
