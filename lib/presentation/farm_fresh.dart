import 'package:farm_fresh_shop_app/di/initializer.dart';
import 'package:farm_fresh_shop_app/helpers/styles/app_color.dart';
import 'package:farm_fresh_shop_app/navigation/app_navigation.dart';
import 'package:farm_fresh_shop_app/navigation/route_generator.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmFreshApp extends StatelessWidget {
  const FarmFreshApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: Initializer.blocProviders,
      child: DevicePreview(
          enabled: true,
          backgroundColor: Colors.white,
          isToolbarVisible: true,
          builder: (context) {
            return ScreenUtilInit(
                useInheritedMediaQuery: true,
                designSize: const Size(300, 200),
                builder: (context, _) {
                  SystemChrome.setSystemUIOverlayStyle(
                      const SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                  ));
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                        scaffoldBackgroundColor: Colors.white,
                        textSelectionTheme: TextSelectionThemeData(
                          cursorColor: AppColor.primary,
                          selectionColor: Colors.grey,
                          selectionHandleColor: AppColor.primary,
                        )),
                    navigatorKey: AppNavigation.navigatorKey,
                    onGenerateRoute: generateRoute,
                    builder: DevicePreview.appBuilder,
                  );
                });
          }),
    );
  }
}
