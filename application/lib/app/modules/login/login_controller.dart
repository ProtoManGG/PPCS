import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../data/models/failure_model.dart';
import '../../data/repository/repository.dart';
import '../../services/services.dart';

class LoginController extends GetxController with StateMixin {
  final Repository repository;
  LoginController({@required this.repository}) {
    change("Initial", status: RxStatus.empty());
  }

  Future<void> login({
    @required String email,
    @required String password,
  }) async {
    try {
      change('Loading', status: RxStatus.loading());
      final _storage = StorageService().instance;
      _storage.box.write(ngrokKey, baseUrl);
      final body = await repository.login(email: email, password: password);
      _storage.box.write(storageKey, body["access_token"]);
      change('Success', status: RxStatus.success());
    } on Failure catch (f) {
      change('Failure', status: RxStatus.error(f.toString()));
    }
  }
}
