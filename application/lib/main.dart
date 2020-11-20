import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/services/services.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(
    GetMaterialApp(
      title: "Crowd Safety",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData.dark(),
    ),
  );
}
