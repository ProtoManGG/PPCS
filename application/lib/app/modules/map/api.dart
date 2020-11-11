import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../consts.dart';
import '../../routes/app_pages.dart';
import 'model/hotspot_model.dart';

const baseUrl = '${Styling.kBaseUrl}covid';

Dio dio = Dio();
Future<HotSpotModel> locationSender(double latitude, double longitude) async {
  final GetStorage box = GetStorage();
  try {
    final Response response = await dio.post(
      baseUrl,
      data: {
        "lat": latitude,
        "longi": longitude,
        "access_token": await box.read("_accessToken"),
      },
    );
    if (response.statusCode == 200 && response.data != null) {
      final HotSpotModel hotSpotModel =
          HotSpotModel.fromJson(response.data as Map<String, dynamic>);
      box.write("_accessToken", response.data["access_token"]);
      return hotSpotModel;
    } else {
      return null;
    }
  } on DioError catch (e) {
    if (e.response.statusCode == 500 || e.response.statusCode == 401) {
      Get.snackbar('Token Expired', e.response.statusMessage);
      final GetStorage box = GetStorage();
      box.remove("_accessToken");
      Get.offAllNamed(Routes.LOGIN);
    }
    Get.snackbar(e.response.statusCode.toString(), e.response.statusMessage);
    return null;
  }
}
