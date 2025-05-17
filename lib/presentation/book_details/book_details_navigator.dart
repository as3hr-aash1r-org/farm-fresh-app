import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';
import 'package:farm_fresh_shop_app/presentation/read_book/read_book_navigator.dart';

import '../../navigation/app_navigation.dart';
import '../../navigation/route_name.dart';

class BookDetailNavigator with ReadBookRoute {
  @override
  final AppNavigation navigation;
  BookDetailNavigator(this.navigation);

  void goBack() {
    navigation.pop();
  }
}

mixin BookDetailRoute {
  AppNavigation get navigation;

  navigateToBookDetail(BookEntity book) {
    navigation.push(RouteName.bookDetails, arguments: {"book": book});
  }
}
