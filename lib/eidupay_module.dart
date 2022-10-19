import 'package:eidupay/main.dart';
import 'package:eidupay/app_config.dart';
import 'package:eidupay/network.dart';

class EidupayModule {
  static void injectModule(AppConfig appConfig) async {
    injector.registerFactory<Network>(Network.create);

    injector.registerSingleton<AppConfig>(appConfig);
  }
}
