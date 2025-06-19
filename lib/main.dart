import 'package:farm_fresh_shop_app/initializer.dart';
import 'package:flutter/material.dart';
import 'presentation/farm_fresh.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Initializer.init();
  runApp(const FarmFreshApp());
}


// bundle id: com.farmfreshshop.app