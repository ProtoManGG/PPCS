import 'package:get/get.dart';

import '../../data/providers/api_client.dart';
import '../../data/repository/auth_repository.dart';
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
