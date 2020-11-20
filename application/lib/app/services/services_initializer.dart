import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/services/services.dart';

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().initialize());
  Get.put(ApiService());
}
