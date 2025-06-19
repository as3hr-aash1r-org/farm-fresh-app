import 'package:farm_fresh_shop_app/helpers/widgets/app_button.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/register_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/styles/app_images.dart';
import '../../../helpers/widgets/app_text_field.dart';
import '../../../helpers/widgets/farm_fresh_asset.dart';
import '../../../initializer.dart';
import 'register_screen_cubit.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
                'Forget Password',
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
              const SizedBox(height: 40),
              BlocBuilder<RegisterScreenCubit, RegisterScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  return AppButton(
                    text: "Send",
                    onPressed: () {
                      cubit.onForgetPassword();
                    },
                    isLoading: state.isLoading,
                  );
                },
              ),
              Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
