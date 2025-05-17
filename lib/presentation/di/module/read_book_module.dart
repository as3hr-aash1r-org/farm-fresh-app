import 'package:farm_fresh_shop_app/domain/entities/book_entity.dart';

import '../../../di/service_locator.dart';
import '../../read_book/read_book_cubit.dart';
import '../../read_book/read_book_navigator.dart';

class ReadBookModule {
  static Future<void> configureReadBookModuleInjection() async {
    sl.registerLazySingleton<ReadBookNavigator>(() => ReadBookNavigator(sl()));

    sl.registerFactoryParam<ReadBookCubit, BookEntity, dynamic>(
      (params, _) => ReadBookCubit(
        params,
        sl(),
      ),
    );
  }
}
