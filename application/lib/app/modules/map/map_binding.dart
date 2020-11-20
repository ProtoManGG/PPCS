import 'package:get/get.dart';
import '../../data/providers/api_client.dart';
import '../../data/repository/repository.dart';

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
