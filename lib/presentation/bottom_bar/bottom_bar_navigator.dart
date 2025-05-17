import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class BottomBarNavigator {
  final AppNavigation navigation;

  void exitApp() {
    navigation.exitApp();
  }

  BottomBarNavigator(this.navigation);
}

mixin BottomBarRoute {
  void goToBottomBar() {
    navigation.pushReplacement(RouteName.bottomBar);
  }

  AppNavigation get navigation;
}
