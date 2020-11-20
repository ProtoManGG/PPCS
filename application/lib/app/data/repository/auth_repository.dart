import 'package:flutter/foundation.dart';
import 'package:getx_ecosystem_trial/app/data/providers/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository({@required this.apiClient})
      : assert(apiClient != null);

  // Future getHotspotModel(
  //         {@required double latitude, @required double longitude}) async =>
  //     apiClient.getHotspotModel(latitude: latitude, longitude: longitude);

  Future login({
    @required String email,
    @required String password,
  }) async =>
      apiClient.login(email: email, password: password);

  Future signUp({
    @required String username,
    @required String email,
    @required String password,
    @required double latitude,
    @required double longitude,
    @required int phonenum,
  }) async =>
      apiClient.signUp(
        username: username,
        email: email,
        password: password,
        latitude: latitude,
        longitude: longitude,
        phonenum: phonenum,
      );
}
