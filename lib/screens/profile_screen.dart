import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../providers/order_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../utils/formatters.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        showCartIcon: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Info Section
            Container(
              padding: const EdgeInsets.all(16),
              color: AppConstants.primaryColor.withOpacity(0.1),
              child: Row(
                children: [
                  // User Avatar
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // User Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? 'Guest User',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'Sign in to view your profile',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Profile Options
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Account',
                    style: AppConstants.subheadingStyle,
                  ),
                  const SizedBox(height: 16),

                  // Personal Information
                  _buildProfileOption(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    onTap: () {
                      // Navigate to personal information screen
                    },
                  ),

                  // Order History
                  _buildProfileOption(
                    icon: Icons.history,
                    title: 'Order History',
                    onTap: () {
                      // Show order history
                      _showOrderHistory(context, orderProvider);
                    },
                  ),

                  // Addresses
                  _buildProfileOption(
                    icon: Icons.location_on_outlined,
                    title: 'Addresses',
                    onTap: () {
                      // Navigate to addresses screen
                    },
                  ),

                  // Logout
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () async {
                      // Show confirmation dialog
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Logout'),
                          content:
                              const Text('Are you sure you want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Logout'),
                            ),
                          ],
                        ),
                      );

                      if (confirm == true) {
                        await userProvider.logout();
                        if (!context.mounted) return;
                        Navigator.pushReplacementNamed(context, '/login');
                      }
                    },
                  ),

                  // Payment Methods
                  _buildProfileOption(
                    icon: Icons.credit_card,
                    title: 'Payment Methods',
                    onTap: () {
                      // Navigate to payment methods screen
                    },
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    'Settings',
                    style: AppConstants.subheadingStyle,
                  ),
                  const SizedBox(height: 16),

                  // Notifications
                  _buildProfileOption(
                    icon: Icons.notifications_outlined,
                    title: 'Notifications',
                    onTap: () {
                      // Navigate to notifications screen
                    },
                  ),

                  // Privacy Policy
                  _buildProfileOption(
                    icon: Icons.privacy_tip_outlined,
                    title: 'Privacy Policy',
                    onTap: () {
                      // Navigate to privacy policy screen
                    },
                  ),

                  // Terms & Conditions
                  _buildProfileOption(
                    icon: Icons.description_outlined,
                    title: 'Terms & Conditions',
                    onTap: () {
                      // Navigate to terms & conditions screen
                    },
                  ),

                  // Logout
                  _buildProfileOption(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      // Logout user
                      userProvider.logout();
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    showDivider: false,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 3, // Profile tab
        onTap: (index) => NavigationHelper.handleNavigation(context, index),
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: AppConstants.primaryColor),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          contentPadding: EdgeInsets.zero,
          onTap: onTap,
        ),
        if (showDivider) const Divider(),
      ],
    );
  }

  void _showOrderHistory(BuildContext context, OrderProvider orderProvider) {
    final orders = orderProvider.orders;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Order History',
              style: AppConstants.headingStyle,
            ),
            const SizedBox(height: 16),

            // Orders List
            Expanded(
              child: orders.isEmpty
                  ? const Center(
                      child: Text('No orders yet'),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (ctx, i) => Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Order ID and Date
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Order #${orders[i].id.substring(0, 8)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    orders[i]
                                        .orderDate
                                        .toString()
                                        .substring(0, 10),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Status
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  orders[i].status,
                                  style: TextStyle(
                                    color: AppConstants.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Items
                              ...orders[i].items.map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${item.quantity}x',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(item.product.name),
                                      ],
                                    ),
                                  )),
                              const SizedBox(height: 8),

                              // Total
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text('Total: '),
                                  Text(
                                    '${Formatters.formatPrice(orders[i].totalAmount)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstants.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
