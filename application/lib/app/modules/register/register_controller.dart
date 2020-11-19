import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../consts.dart' as style;

enum RegisterState { initial, loading, loaded }

class RegisterController extends GetxController {
  GetStorage box = GetStorage();
  Rx<RegisterState> state = RegisterState.initial.obs;
  String failure;
  String data;

  Future<void> postService({
    @required String email,
    @required String password,
    @required String fullName,
    @required String phoneNum,
  }) async {
    try {
      // final MapController mapController = Get.put(MapController());
      state.value = RegisterState.loading;
      await Dio().post(
        '${style.Styling.kBaseUrl}signup',
        data: {
          // "lat": mapController.locationData.value.latitude,
          // "longi": mapController.locationData.value.longitude,
          "lat": 0,
          "longi": 0,
          "username": fullName,
          "phone_no": phoneNum,
          "email": email, //! Encrypt
          "password": password,
        },
      ).then((val) {
        box.write("_accessToken", val.data["access_token"]);
        state.value = RegisterState.loaded;
        failure = null;
        data = "Successfully Registered 😊";
      });
    } on DioError catch (e) {
      state.value = RegisterState.loaded;
      failure = "${e.response.data} 🐱‍🚀 ${e.response.statusCode}";
    } on SocketException {
      state.value = RegisterState.loaded;
      failure = 'No Internet connection 😑';
    } on HttpException {
      state.value = RegisterState.loaded;
      failure = "Couldn't find the post 😱";
    } on FormatException {
      state.value = RegisterState.loaded;
      failure = "Bad response format 👎";
    }
  }
}
