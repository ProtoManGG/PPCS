import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final GetStorage box = GetStorage();
  runApp(
    GetMaterialApp(
      title: "Crowd Safety",
      initialRoute: box.hasData("_accessToken") ? Routes.MAP : Routes.LOGIN,
      getPages: AppPages.routes,
      theme: ThemeData.dark(),
    ),
  );
}
