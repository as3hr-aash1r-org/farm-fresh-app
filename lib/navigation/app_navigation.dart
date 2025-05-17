import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppNavigation {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final context = navigatorKey.currentState!.context;
  static void push(String routeName, {arguments}) {
    Navigator.pushNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static void pop() {
    Navigator.pop(context);
  }

  static void exitApp() async {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  static void pushReplacement(String routeName, {arguments}) {
    Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
    );
  }

  static getToLast() {
    Navigator.popUntil(context, (route) => route.isFirst);
  }
}
