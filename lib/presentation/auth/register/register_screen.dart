import 'package:farm_fresh_shop_app/helpers/widgets/app_button.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/register_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../helpers/styles/app_color.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/widgets/app_text_field.dart';
import '../../../helpers/widgets/farm_fresh_asset.dart';
import '../../../initializer.dart';
import 'register_screen_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = sl<RegisterScreenCubit>();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                const Text(
                  'Register Account',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                Text(
                  'Hello, Welcome to Farm Fresh Shop',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.76,
                    color: Color(0xff595959),
                  ),
                ),
                SizedBox(height: 40),
                AppTextField(
                  onChanged: (val) => cubit.onEmailChange(val),
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Please enter email";
                    }
                    final emailRegx =
                        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegx.hasMatch(p0)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                  hintText: "Email",
                  prefixIcon: FarmFreshAsset(image: AppImages.atTheRate),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  onChanged: (val) => cubit.onUserNameChange(val),
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Please enter user name";
                    }
                    if (p0.length < 3) {
                      return "User name must be at least 3 characters";
                    }
                    if (p0.length > 10) {
                      return "User name cannot exceed 8 characters";
                    }
                    return null;
                  },
                  hintText: "UserName",
                  prefixIcon: FarmFreshAsset(
                    image: AppImages.user,
                    width: 20,
                  ),
                ),
                const SizedBox(height: 16),
                AppTextField(
                  onChanged: (val) => cubit.onPasswordChange(val),
                  passwordField: true,
                  validator: (p0) {
                    if (p0!.isEmpty) {
                      return "Please enter password";
                    }
                    if (p0.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  hintText: "Password",
                  prefixIcon: FarmFreshAsset(image: AppImages.lock),
                ),
                const SizedBox(height: 40),
                BlocBuilder<RegisterScreenCubit, RegisterScreenState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return AppButton(
                      text: "Register",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          cubit.onRegister();
                        }
                      },
                      isLoading: state.isLoading,
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'Already have an account??',
                      style: TextStyle(color: Color(0xff979797)),
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigation.pushReplacement(RouteName.login);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(
                            color: AppColor.green, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
