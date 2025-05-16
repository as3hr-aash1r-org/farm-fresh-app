import 'package:carousel_slider/carousel_slider.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/product_provider.dart';
import '../utils/image_assets.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final controller = carousel.CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    // Fetch products when the screen loads
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchProducts();
    });

    return Scaffold(
      appBar: const CustomAppBar(
        title: AppConstants.appName,
        showBackButton: false,
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Banner
            _buildHeroBanner(),

            // Featured Products Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Featured Products',
                style: AppConstants.headingStyle,
              ),
            ),
            _buildFeaturedProducts(context),

            // Special Offer Banner
            _buildSpecialOfferBanner(context),

            // Categories Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Browse by Category',
                style: AppConstants.headingStyle,
              ),
            ),
            _buildCategories(context),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0,
        onTap: (index) => NavigationHelper.handleNavigation(context, index),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppConstants.primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.eco,
                      size: 40,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  AppConstants.appName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  AppConstants.appTagline,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            onTap: () => Navigator.pop(context),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.category,
            title: 'Products',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/products');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.shopping_cart,
            title: 'Cart',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cart');
            },
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/profile');
            },
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.contact_phone,
            title: 'Contact Us',
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/contact');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryColor),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildHeroBanner() {
    return carousel.CarouselSlider(
      carouselController: controller,
      options: carousel.CarouselOptions(
        height: 200.0,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.9,
      ),
      items: [
        _buildBannerItem(
          'Farm Fresh Shop',
          'Delivering the Taste of Pakistan to the USA',
          Colors.green.shade700,
        ),
        _buildBannerItem(
          'Fresh & Juicy Mangoes',
          'Directly from our farms in Punjab',
          AppConstants.secondaryColor,
        ),
        _buildBannerItem(
          'Premium Quality',
          'Handpicked and carefully packed',
          Colors.teal.shade700,
        ),
      ],
    );
  }

  Widget _buildBannerItem(String title, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: color,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Shop Now'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (ctx, productProvider, _) {
        final featuredProducts = productProvider.featuredProducts;

        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: featuredProducts.length,
            itemBuilder: (ctx, i) => Padding(
              padding: const EdgeInsets.only(right: 16),
              child: ProductCard(
                product: featuredProducts[i],
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/product-details',
                    arguments: featuredProducts[i].id,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpecialOfferBanner(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppConstants.secondaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Special Offer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Fresh & Juicy Mangoes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/products');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppConstants.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Shop Now'),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.eco,
                size: 60,
                color: AppConstants.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: AppConstants.categories.length,
        itemBuilder: (ctx, i) {
          final category = AppConstants.categories[i];
          return GestureDetector(
            onTap: () {
              // Set the selected category and navigate to products screen
              Provider.of<ProductProvider>(context, listen: false)
                  .setCategory(category);
              Navigator.pushNamed(context, '/products');
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.eco,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    category,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
