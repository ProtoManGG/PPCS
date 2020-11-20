import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';
import 'package:getx_ecosystem_trial/app/data/repository/repository.dart';

import 'map_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapController>(
      () => MapController(
        repository: Repository(
          apiClient: ApiClient(),
        ),
      ),
    );
  }
}
