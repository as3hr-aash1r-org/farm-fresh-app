import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import 'presentation/farm_fresh.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Initializer.init().then(((_) {
    runApp(const FarmFreshApp());
  }));
}


/// bundle id: {{com.farmfreshshop.app}}  for both android and IOS (please verify beforeHand that all necessary files has this same bundleId, I changed it from com.farmfreshshop.farmFreshShopApp previosuly).
/// no firebase is used in this app!!