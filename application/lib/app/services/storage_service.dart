import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  StorageService get instance => Get.find();
  late GetStorage box;

  Future<StorageService> initialize() async {
    await GetStorage.init();
    box = GetStorage();
    return this;
  }

  //  GetStorage storageBox() {
  //   final GetStorage box = GetStorage();
  //   return box;
  // }
}
