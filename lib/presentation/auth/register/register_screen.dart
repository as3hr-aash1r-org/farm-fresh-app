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

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = sl<RegisterScreenCubit>();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                hintText: "Email",
                prefixIcon: FarmFreshAsset(image: AppImages.atTheRate),
              ),
              const SizedBox(height: 16),
              AppTextField(
                onChanged: (val) => cubit.onUserNameChange(val),
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
                      cubit.onRegister();
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
      );
    });
  }
}
