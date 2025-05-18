import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_images.dart';
import 'package:farm_fresh_shop_app/presentation/on_boarding/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'on_boarding_state.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnBoardingCubit>(
      create: (context) => OnBoardingCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            _buildOnboardingPage(
              illustration: AppImages.onboarding,
              title: 'Get your favourite Manogoes',
              subtitle:
                  'All your favorites are here, enjoy your read at home or traveling, or anywhere else!',
            ),
            Positioned(
              bottom: 80,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: BlocBuilder<OnBoardingCubit, OnBoardingState>(
                      builder: (context, state) {
                        return ElevatedButton(
                          onPressed: () {
                            context.read<OnBoardingCubit>().onGetInPressed();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Get In'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String illustration,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            illustration,
            height: 300,
            width: 300,
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
