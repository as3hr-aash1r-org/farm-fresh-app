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
                      fontSize: 12.76,
                      color: Color(0xff595959),
                    ),
                  ),
                  const SizedBox(height: 80),
                  AppTextField(
                    onChanged: (val) => cubit.onEmailChange(val),
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    onChanged: (val) => cubit.onPasswordChange(val),
                    passwordField: true,
                    hintText: "Password",
                    prefixIcon: Icons.lock_person_rounded,
                  ),
                  const SizedBox(height: 40),
                  AppButton(
                    isLoading: state.isLoading,
                    text: "Log In",
                    onPressed: cubit.onLogin,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Not Registered Yet?',
                        style: TextStyle(color: Color(0xff979797)),
                      ),
                      TextButton(
                        onPressed: () {
                          AppNavigation.pushReplacement(RouteName.register);
                        },
                        child: const Text(
                          'Create an Account',
                          style: TextStyle(
                              color: AppColor.primary,
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
