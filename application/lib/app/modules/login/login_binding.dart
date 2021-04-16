import 'package:get/get.dart';

import '../../data/providers/api_client.dart';
import '../../data/repository/repository.dart';
import 'login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(repository: Repository(apiClient: ApiClient())),
    );
  }
}
