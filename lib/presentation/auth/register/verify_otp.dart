import 'package:farm_fresh_shop_app/helpers/widgets/app_button.dart';
import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/register_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../helpers/utils.dart';
import '../../../helpers/widgets/otp_field.dart';
import 'register_screen_cubit.dart';

class VerifyOtp extends StatelessWidget {
  const VerifyOtp({super.key, this.isRegister = false});
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      final cubit = sl<RegisterScreenCubit>();
      cubit.initiateOtpScreen();
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              const Text(
                'Verify OTP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text(
                'Hello, Welcome to Farm Fresh Shop',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.76,
                  color: Color(0xff595959),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please enter the 5-digit verification code sent to ${cubit.email}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xff757575),
                ),
              ),
              const SizedBox(height: 40),
              VerificationOtpInput(
                codeValues: cubit.phoneHelper.verificationCode,
                focusNodes: cubit.phoneHelper.focusNodes,
                onChanged: cubit.phoneHelper.updateVerificationDigit,
              ),
              const SizedBox(height: 24),
              BlocBuilder<RegisterScreenCubit, RegisterScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.canResendOtp
                            ? "Didn't receive code? "
                            : "Resend code in ",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xff757575),
                        ),
                      ),
                      if (!state.canResendOtp)
                        Text(
                          cubit.phoneHelper.getFormattedTime(),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4CAF50),
                          ),
                        ),
                      if (state.canResendOtp)
                        GestureDetector(
                          onTap: state.isResending ? null : cubit.onResendOtp,
                          child: Text(
                            state.isResending ? "Sending..." : "Resend",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: state.isResending
                                  ? const Color(0xff9E9E9E)
                                  : const Color(0xff4CAF50),
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              BlocBuilder<RegisterScreenCubit, RegisterScreenState>(
                bloc: cubit,
                builder: (context, state) {
                  return AppButton(
                    text: "Verify",
                    onPressed: cubit.phoneHelper.isVerificationCodeComplete()
                        ? () => cubit.onVerifyOtp(isRegister: isRegister)
                        : () {
                            showToast("Please enter complete OTP");
                          },
                    isLoading: state.isLoading,
                  );
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    });
  }
}
