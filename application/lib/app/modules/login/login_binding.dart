import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';
import 'package:getx_ecosystem_trial/app/data/repository/auth_repository.dart';

import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        authRepository: AuthRepository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
