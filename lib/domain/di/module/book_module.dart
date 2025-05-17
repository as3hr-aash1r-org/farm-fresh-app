import '../../../data/book/book_data_repository.dart';
import '../../../di/service_locator.dart';
import '../../repositories/book_repository.dart';

class BookModule {
  static Future<void> configureBookModuleInjection() async {
    sl.registerSingleton<BookRepository>(
      BookDataRepository(),
    );
  }
}
