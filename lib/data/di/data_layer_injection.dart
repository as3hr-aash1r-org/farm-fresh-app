import 'module/local_module.dart';

class DataLayerInjection {
  static Future<void> configureDataLayerInjction() async {
    await LocalModule.configureLocalModuleInjection();
  }
}
