import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../initializer.dart';
import 'components/profile_screen_dialogs.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = sl<ProfileCubit>();
      return BlocBuilder<ProfileCubit, ProfileState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xff1E1E1E),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: InkWell(
                onTap: () => AppNavigation.pop(),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              centerTitle: true,
              iconTheme: const IconThemeData(
                color: Color(0xff1E1E1E),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Header
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color(0xff4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xff4CAF50).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        // Avatar
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: const Color(0xff4CAF50),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 16),
                        // User Name
                        Text(
                          state.user.userName ?? 'User',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1E1E1E),
                          ),
                        ),
                        const SizedBox(height: 4),
                        // User Email
                        Text(
                          state.user.email ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: const Color(0xff1E1E1E).withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Menu Options
                  _buildMenuTile(
                    icon: Icons.lock_outline,
                    title: 'Change Password',
                    onTap: () => showChangePasswordDialog(context, cubit),
                    isLoading: state.changePasswordLoading,
                  ),

                  const SizedBox(height: 12),

                  _buildMenuTile(
                    icon: Icons.delete_outline,
                    title: 'Delete Account',
                    onTap: () => showDeleteAccountDialog(context, cubit),
                    isDestructive: true,
                    isLoading: state.deleteAccountLoading,
                  ),

                  const SizedBox(height: 12),

                  _buildMenuTile(
                    icon: Icons.logout,
                    title: 'Log Out',
                    onTap: () => showLogoutDialog(context, cubit),
                    isDestructive: true,
                  ),

                  const SizedBox(height: 32),

                  // App Info
                  Text(
                    '🥭 Farm Fresh Mango Shop',
                    style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xff4CAF50).withOpacity(0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xff1E1E1E).withOpacity(0.4),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
    bool isLoading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xff4CAF50).withOpacity(0.1),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff4CAF50).withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isDestructive
                ? Colors.red.withOpacity(0.1)
                : const Color(0xff4CAF50).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isDestructive ? Colors.red : const Color(0xff4CAF50),
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isDestructive ? Colors.red : const Color(0xff1E1E1E),
          ),
        ),
        trailing: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDestructive ? Colors.red : const Color(0xff4CAF50),
                  ),
                ),
              )
            : Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: const Color(0xff1E1E1E).withOpacity(0.3),
              ),
        onTap: isLoading ? null : onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
