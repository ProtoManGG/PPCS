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
  String data = 'Press the button 👇';

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
      currentState.value = AppState.loaded;
    } on Failure catch (f) {
      data = f.toString();
      currentState.value = AppState.failure;
    }
  }
}
