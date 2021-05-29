import 'package:get/get.dart';

import '../constants/constants.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/map/map_binding.dart';
import '../modules/map/map_view.dart';
import '../modules/register/register_binding.dart';
import '../modules/register/register_view.dart';
import '../services/services.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final _storage = StorageService().instance;
  // final box = ;

  // ignore: non_constant_identifier_names
  static final INITIAL =
      _storage.box.hasData(storageKey) ? Routes.MAP : Routes.LOGIN;

  static final routes = [
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
  ];
}
