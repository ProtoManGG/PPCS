import 'package:dio/dio.dart';
import 'package:get/get.dart';
// import 'package:getx_ecosystem_trial/app/modules/login/controllers/ngrok_controller.dart';

class ApiService extends GetxService {
  ApiService get instance => Get.find();

  final dio = Dio(
    BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ),
  );
}
