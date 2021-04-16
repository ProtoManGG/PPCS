import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../providers/api_client.dart';

class Repository {
  final ApiClient apiClient;

  Repository({@required this.apiClient}) : assert(apiClient != null);

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

  Future getHotSpotZones({
    @required double latitude,
    @required double longitude,
    @required String accessToken,
  }) async {
    return apiClient.getHotSpotZones(
      latitude: latitude,
      longitude: longitude,
      accessToken: accessToken,
    );
  }

  Future getRoutes({
    @required Marker origin,
    @required Marker destination,
    @required String accessToken,
  }) async {
    return apiClient.getRoutes(
      origin: origin,
      destination: destination,
      accessToken: accessToken,
    );
  }
}
