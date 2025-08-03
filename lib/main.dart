import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import 'presentation/farm_fresh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Initializer.init().then(((_) {
    runApp(const FarmFreshApp());
  }));
}


/// bundle id: {{com.farmfreshshop.app}}  for Android.
/// bundle id: {{com.freshFarmShop.app}} for IOS.
/// no firebase is used in this app!!