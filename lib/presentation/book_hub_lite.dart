import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_generator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookHubLite extends StatelessWidget {
  const BookHubLite({super.key});
  @override
  Widget build(BuildContext context) {
    return DevicePreview(
        enabled: true,
        backgroundColor: Colors.white,
        defaultDevice: Devices.ios.iPhone13ProMax,
        isToolbarVisible: true,
        tools: const [
          DeviceSection(
            model: true,
            orientation: false,
            frameVisibility: false,
            virtualKeyboard: false,
          ),
        ],
        builder: (context) {
          return ScreenUtilInit(
              useInheritedMediaQuery: true,
              designSize: const Size(300, 200),
              builder: (context, _) {
                SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                ));
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    scaffoldBackgroundColor: Colors.white,
                  ),
                  navigatorKey: AppNavigation.navigatorKey,
                  onGenerateRoute: generateRoute,
                  builder: DevicePreview.appBuilder,
                );
              });
        });
  }
}
