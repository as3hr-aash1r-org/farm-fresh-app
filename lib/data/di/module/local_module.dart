import '../../local_storage/local_storage_repository.dart';

import '../../../di/service_locator.dart';

class LocalModule {
  static Future<void> configureLocalModuleInjection() async {
    sl.registerSingleton<LocalStorageRepository>(LocalStorageRepository());
  }
}
