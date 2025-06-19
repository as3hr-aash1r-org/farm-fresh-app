// ignore_for_file: unused_local_variable

import 'package:farm_fresh_shop_app/navigation/route_name.dart';
import 'package:farm_fresh_shop_app/presentation/auth/login/login_screen.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/forget_password.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/register_screen.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/reset_password.dart';
import 'package:farm_fresh_shop_app/presentation/auth/register/verify_otp.dart';
import 'package:farm_fresh_shop_app/presentation/bottom_bar/bottom_bar.dart';
import 'package:farm_fresh_shop_app/presentation/cart/cart_screen.dart';
import 'package:farm_fresh_shop_app/presentation/cart/components/order_success.dart';
import 'package:farm_fresh_shop_app/presentation/cart/payment_view.dart';
import 'package:farm_fresh_shop_app/presentation/on_boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';

enum TransitionType {
  fade,
  slide,
}

Route<dynamic> generateRoute(RouteSettings settings) {
  final args =
      (settings.arguments ?? <String, dynamic>{}) as Map<String, dynamic>;

  switch (settings.name) {
    case RouteName.splash:
      return getRoute(const OnboardingScreen(), TransitionType.fade);
    case RouteName.login:
      return getRoute(const LoginScreen(), TransitionType.fade);
    case RouteName.register:
      return getRoute(const RegisterScreen(), TransitionType.fade);
    case RouteName.verifyOtp:
      return getRoute(VerifyOtp(), TransitionType.fade);
    case RouteName.forgetPassword:
      return getRoute(ForgetPassword(), TransitionType.fade);
    case RouteName.resetPassword:
      return getRoute(ResetPassword(), TransitionType.fade);
    case RouteName.bottomBar:
      return getRoute(BottomBar(), TransitionType.fade);
    case RouteName.cart:
      return getRoute(CartScreen(), TransitionType.fade);
    case RouteName.successOrder:
      return getRoute(
          OrderSuccessScreen(amount: args['amount']), TransitionType.fade);
    case RouteName.paymentWebView:
      return getRoute(PaymentWebView(url: args['url']), TransitionType.fade);

    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('PAGE NOT FOUND!!')),
        ),
      );
  }
}

PageRouteBuilder getRoute(Widget page, TransitionType transitionType) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => page,
    transitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (transitionType) {
        case TransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case TransitionType.slide:
          const begin = Offset(1, 0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
      }
    },
  );
}
