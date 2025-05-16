import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../constants/app_constants.dart';
import '../providers/product_provider.dart';
import '../utils/navigation_helper.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/product_card.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({Key? key}) : super(key: key);

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  // Refresh controller for pull-to-refresh functionality
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    // Fetch products when the screen loads
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    // Refresh products
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    _refreshController.refreshCompleted();
  }

  // Toggle search mode
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        Provider.of<ProductProvider>(context, listen: false).clearSearch();
      }
    });
  }

  // Handle search
  void _handleSearch(String query) {
    Provider.of<ProductProvider>(context, listen: false).searchProducts(query);
  }

  // Build category filter
  Widget _buildCategoryFilter(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final categories = AppConstants.categories;

    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (ctx, i) {
          final category = categories[i];
          final isSelected = productProvider.selectedCategory == category;

          return GestureDetector(
            onTap: () {
              productProvider.setCategory(category);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppConstants.primaryColor
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Build empty state widget
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          const Text(
            'No products available in this category',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false)
                  .setCategory('All');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppConstants.primaryColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Explore All Products'),
          ),
        ],
      ),
    );
  }

  // Build loading state widget
  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(AppConstants.primaryColor),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading products...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isSearching
          ? AppBar(
              backgroundColor: AppConstants.primaryColor,
              title: TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Search products...',
                  hintStyle: TextStyle(color: Colors.white70),
                  border: InputBorder.none,
                ),
                onChanged: _handleSearch,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: _toggleSearch,
                ),
              ],
            )
          : CustomAppBar(
              title: 'Shop',
              actions: [
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: _toggleSearch,
                ),
              ],
            ),
      body: Column(
        children: [
          // Category Filter
          _buildCategoryFilter(context),

          // Product Grid with Pull-to-Refresh
          Expanded(
            child: Consumer<ProductProvider>(
              builder: (ctx, productProvider, _) {
                final products = productProvider.products;

                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  header: const WaterDropHeader(
                    waterDropColor: AppConstants.primaryColor,
                    complete: Text('Refresh completed',
                        style: TextStyle(color: AppConstants.primaryColor)),
                    failed: Text('Refresh failed',
                        style: TextStyle(color: Colors.red)),
                  ),
                  child: productProvider.isLoading
                      ? _buildLoadingState()
                      : products.isEmpty
                          ? _buildEmptyState()
                          : GridView.builder(
                              padding: const EdgeInsets.all(16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: products.length,
                              itemBuilder: (ctx, i) {
                                return ProductCard(
                                  product: products[i],
                                );
                              },
                            ),
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: CustomBottomNavBar(
      //   currentIndex: 1, // Products tab
      //   onTap: (index) => NavigationHelper.handleNavigation(context, index),
      // ),
    );
  }
}
