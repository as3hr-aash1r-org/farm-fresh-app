import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/helpers/widgets/farm_fresh_asset.dart';
import 'package:farm_fresh_shop_app/presentation/auth/login/login_screen_cubit.dart';
import 'package:farm_fresh_shop_app/presentation/auth/login/login_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../helpers/styles/app_color.dart';
import '../../../helpers/widgets/app_button.dart';
import '../../../helpers/widgets/app_text_field.dart';
import '../../../navigation/app_navigation.dart';
import '../../../navigation/route_name.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginScreenCubit>(
      create: (context) => LoginScreenCubit(),
      child: BlocBuilder<LoginScreenCubit, LoginScreenState>(
          builder: (context, state) {
        final cubit = context.read<LoginScreenCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  const Text(
                    'Login Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    'Hello, Welcome to Farm Fresh Shop',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff595959),
                    ),
                  ),
                  const SizedBox(height: 80),
                  AppTextField(
                    onChanged: (val) => cubit.onEmailChange(val),
                    hintText: "Email",
                    prefixIcon: FarmFreshAsset(image: AppImages.atTheRate),
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    onChanged: (val) => cubit.onPasswordChange(val),
                    passwordField: true,
                    hintText: "Password",
                    prefixIcon: FarmFreshAsset(image: AppImages.lock),
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    isLoading: state.isLoading,
                    text: "Log In",
                    onPressed: cubit.onLogin,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          AppNavigation.push(RouteName.forgetPassword);
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                              decorationColor: AppColor.green,
                              decoration: TextDecoration.underline,
                              color: AppColor.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Not Registered Yet?',
                        style: TextStyle(
                          color: Color(0xff979797),
                          fontSize: 18,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          AppNavigation.pushReplacement(RouteName.register);
                        },
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(
                              color: AppColor.green,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
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
      }),
    );
  }
}
