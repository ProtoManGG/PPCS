import 'package:get/get.dart';

import '../../data/providers/api_client.dart';
import '../../data/repository/auth_repository.dart';
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
