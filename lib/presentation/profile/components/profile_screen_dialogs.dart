import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/presentation/profile/profile_cubit.dart';
import 'package:flutter/material.dart';

void showChangePasswordDialog(BuildContext context, ProfileCubit cubit) {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Change Password',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff1E1E1E),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: oldPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              labelStyle: TextStyle(color: AppColor.green),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green, width: 2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              labelStyle: TextStyle(color: AppColor.green),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColor.green, width: 2),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xff757575)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.oldPassword = oldPasswordController.text;
            cubit.newPassword = newPasswordController.text;
            cubit.changePassword();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Change',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

void showDeleteAccountDialog(BuildContext context, ProfileCubit cubit) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Delete Account',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
      ),
      content: const Text(
        'Are you sure you want to delete your account? This action cannot be undone.',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff1E1E1E),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xff757575)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.deleteAccount();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}

void showLogoutDialog(BuildContext context, ProfileCubit cubit) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: const Text(
        'Log Out',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xff1E1E1E),
        ),
      ),
      content: const Text(
        'Are you sure you want to log out?',
        style: TextStyle(
          fontSize: 14,
          color: Color(0xff1E1E1E),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: Color(0xff757575)),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            cubit.logOut();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Log Out',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}
