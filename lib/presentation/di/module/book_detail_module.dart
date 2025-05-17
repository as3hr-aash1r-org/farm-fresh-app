import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

import '../../book_details/book_details_cubit.dart';
import '../../book_details/book_details_navigator.dart';

import '../../../di/service_locator.dart';

class BookDetailModule {
  static Future<void> configureBookDetailModuleInjection() async {
    sl.registerLazySingleton<BookDetailNavigator>(
        () => BookDetailNavigator(sl()));

    sl.registerFactoryParam<BookDetailsCubit, BookEntity, dynamic>(
      (params, _) => BookDetailsCubit(
        params,
        sl(),
      ),
    );
  }
}
