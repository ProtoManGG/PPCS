import 'package:get/get.dart';

import 'services.dart';

Future<void> initServices() async {
  await Get.putAsync(() => StorageService().initialize());
  Get.put(ApiService());
}
