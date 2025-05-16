import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'constants/app_constants.dart';
import 'providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'providers/product_provider.dart';
import 'providers/user_provider.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/order_confirmation_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/product_listing_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/splash_screen.dart';
import 'utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: '/splash',
        routes: {
          '/splash': (context) => SplashScreen(
                onInitializationComplete: () async {
                  // Check if user is already logged in
                  final userProvider =
                      Provider.of<UserProvider>(context, listen: false);
                  await userProvider.fetchUserData();

                  if (userProvider.isLoggedIn) {
                    Navigator.pushReplacementNamed(context, '/home');
                  } else {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
              ),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/home': (context) => HomeScreen(),
          '/products': (context) => const ProductListingScreen(),
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/order-confirmation': (context) => const OrderConfirmationScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/contact': (context) => const ContactScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/product-details') {
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (context) => ProductDetailScreen(productId: productId),
            );
          }
          return null;
        },
      ),
    );
  }
}
