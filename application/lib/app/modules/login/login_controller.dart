import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../consts.dart';

enum LoginState { initial, loading, loaded }

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  Rx<LoginState> state = LoginState.initial.obs;
  String failure;
  String data;

  Future<void> postService(String email, String password) async {
    try {
      state.value = LoginState.loading;
      await Dio().post(
        '${Styling.kBaseUrl}login',
        data: {
          "email": email, //! Encrypt
          "password": password,
        },
      ).then((val) {
        box.write("_accessToken", val.data["access_token"]);
        state.value = LoginState.loaded;
        failure = null;
        data = "Successfully Logged In 😊";
      });
    } on DioError catch (e) {
      state.value = LoginState.loaded;
      if (e.response == null) {
        failure = "${e.error} 🐱‍🚀";
      } else {
        failure = "${e.response.data['detail']} 🐱‍🚀 ${e.response.statusCode}";
      }
    }
  }
}
