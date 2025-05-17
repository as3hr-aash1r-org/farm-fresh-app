import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class ReadBookNavigator {
  final AppNavigation navigation;
  ReadBookNavigator(this.navigation);

  void goBack() {
    navigation.pop();
  }
}

mixin ReadBookRoute {
  AppNavigation get navigation;

  navigateToReadBook(BookEntity book) {
    navigation.push(RouteName.bookReader, arguments: {"book": book});
  }
}
