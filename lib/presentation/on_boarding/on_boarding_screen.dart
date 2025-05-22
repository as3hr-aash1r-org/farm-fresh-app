import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1000), () {
      localStorageRepository.getValue("token").then(
            (response) => response.fold(
              (error) => AppNavigation.pushReplacement(RouteName.login),
              (token) => AppNavigation.pushReplacement(RouteName.bottomBar),
            ),
          );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
