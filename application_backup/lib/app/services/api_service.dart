import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../constants/api_constants.dart';

class ApiService extends GetxService {
  ApiService get instance => Get.find();

  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  );
}
