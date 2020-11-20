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
import 'package:getx_ecosystem_trial/app/data/repository/auth_repository.dart';
import 'package:getx_ecosystem_trial/app/services/services.dart';

class LoginController extends GetxController {
  AuthRepository authRepository;
  LoginController({@required this.authRepository});

  final currentState = AppState.initial.obs;
  String data = 'Initial';

  Future<void> login(
      {@required String email, @required String password}) async {
    try {
      currentState.value = AppState.loading;
      final _storage = StorageService().instance;
      final body = await authRepository.login(
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
