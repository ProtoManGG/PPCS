import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';
import 'package:getx_ecosystem_trial/app/data/repository/auth_repository.dart';

import 'register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        authRepository: AuthRepository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
