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
import 'register_screen_cubit.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterScreenCubit>(
      create: (context) => RegisterScreenCubit(),
      child: Builder(builder: (context) {
        final cubit = context.read<RegisterScreenCubit>();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                const Text(
                  'Reset Password',
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
                  hintText: "Password",
                  passwordField: true,
                  prefixIcon: FarmFreshAsset(image: AppImages.lock),
                ),
                const SizedBox(height: 40),
                BlocBuilder<RegisterScreenCubit, RegisterScreenState>(
                  builder: (context, state) {
                    return AppButton(
                      text: "Send",
                      onPressed: () {
                        cubit.onResetPassword();
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
      }),
    );
  }
}
