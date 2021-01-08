import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../data/models/failure_model.dart';
import '../../data/repository/repository.dart';
import '../../services/services.dart';

class LoginController extends GetxController {
  final Repository repository;
  LoginController({@required this.repository});

  final currentState = AppState.initial.obs;
  String data = 'Press the button 👇';

  Future<void> login({@required String email, @required String password}) async {
    try {
      currentState.value = AppState.loading;
      final _storage = StorageService().instance;
      final body = await repository.login(email: email, password: password);
      _storage.box.write(storageKey, body["access_token"]);
      currentState.value = AppState.loaded;
    } on Failure catch (f) {
      data = f.toString();
      currentState.value = AppState.failure;
    }
  }
}
