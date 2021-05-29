import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiService extends GetxService {
  ApiService get instance => Get.find();

  final dio = Dio(
    BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    ),
  );
}
