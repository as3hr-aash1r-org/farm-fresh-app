import 'package:flutter/material.dart';
import 'package:farm_fresh_shop_app/di/service_locator.dart';

import 'presentation/book_hub_lite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.configureServiceLocator();
  runApp(const BookHubLite());
}
