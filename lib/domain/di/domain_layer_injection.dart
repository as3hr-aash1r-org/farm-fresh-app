import 'module/book_module.dart';

class DomainLayerInjection {
  static Future<void> configureDataLayerInjection() async {
    await BookModule.configureBookModuleInjection();
  }
}
