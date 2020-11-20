// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:getx_ecosystem_trial/app/constants/api_constants.dart';

// enum RegisterState { initial, loading, loaded }

// class RegisterController extends GetxController {
//   GetStorage box = GetStorage();
//   Rx<RegisterState> state = RegisterState.initial.obs;
//   String failure;
//   String data;

//   Future<void> postService({
//     @required String email,
//     @required String password,
//     @required String fullName,
//     @required String phoneNum,
//   }) async {
//     try {
//       // final MapController mapController = Get.put(MapController());
//       state.value = RegisterState.loading;
//       await Dio().post(
//         '$baseUrl/signup',
//         data: {
//           // "lat": mapController.locationData.value.latitude,
//           // "longi": mapController.locationData.value.longitude,
//           "lat": 0,
//           "longi": 0,
//           "username": fullName,
//           "phone_no": phoneNum,
//           "email": email, //! Encrypt
//           "password": password,
//         },
//       ).then((val) {
//         box.write("_accessToken", val.data["access_token"]);
//         state.value = RegisterState.loaded;
//         failure = null;
//         data = "Successfully Registered 😊";
//       });
//     } on DioError catch (e) {
//       state.value = RegisterState.loaded;
//       failure = "${e.response.data} 🐱‍🚀 ${e.response.statusCode}";
//     } on SocketException {
//       state.value = RegisterState.loaded;
//       failure = 'No Internet connection 😑';
//     } on HttpException {
//       state.value = RegisterState.loaded;
//       failure = "Couldn't find the post 😱";
//     } on FormatException {
//       state.value = RegisterState.loaded;
//       failure = "Bad response format 👎";
//     }
//   }
// }
// import 'package:dio/dio.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:getx_ecosystem_trial/app/constants/api_constants.dart';

// enum LoginState { initial, loading, loaded }

// class LoginController extends GetxController {
//   GetStorage box = GetStorage();
//   Rx<LoginState> state = LoginState.initial.obs;
//   String failure;
//   String data;

//   Future<void> postService(String email, String password) async {
//     try {
//       state.value = LoginState.loading;
//       await Dio().post(
//         '$baseUrl/login',
//         data: {
//           "email": email, //! Encrypt
//           "password": password,
//         },
//       ).then((val) {
//         box.write("_accessToken", val.data["access_token"]);
//         state.value = LoginState.loaded;
//         failure = null;
//         data = "Successfully Logged In 😊";
//       });
//     } on DioError catch (e) {
//       state.value = LoginState.loaded;
//       if (e.response == null) {
//         failure = "${e.error} 🐱‍🚀";
//       } else {
//         failure = "${e.response.data} 🐱‍🚀 ${e.response.statusCode}";
//       }
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_ecosystem_trial/app/constants/constants.dart';
import 'package:getx_ecosystem_trial/app/data/models/failure_model.dart';
import 'package:getx_ecosystem_trial/app/data/repository/repository.dart';
import 'package:getx_ecosystem_trial/app/services/services.dart';

class RegisterController extends GetxController {
  Repository authRepository;
  RegisterController({@required this.authRepository});

  final currentState = AppState.initial.obs;
  String data = 'Initial';

  Future<void> signUp({
    @required String email,
    @required String password,
    @required int phonenum,
    @required String username,
    @required double latitude,
    @required double longitude,
  }) async {
    try {
      currentState.value = AppState.loading;
      final _storage = StorageService().instance;
      final body = await authRepository.signUp(
        username: username,
        phonenum: phonenum,
        longitude: longitude,
        latitude: latitude,
        email: email,
        password: password,
      );
      _storage.box.write(storageKey, body["access_token"]);
      data = body.toString();
      currentState.value = AppState.loaded;
    } on Failure catch (f) {
      data = f.toString();
      currentState.value = AppState.failure;
    }
  }
}
