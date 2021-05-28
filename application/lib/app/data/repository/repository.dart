import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../providers/api_client.dart';

class Repository {
  Repository({required this.apiClient});

  final ApiClient apiClient;

  Future login({
    required String email,
    required String password,
  }) async =>
      apiClient.login(email: email, password: password);

  Future signUp({
    required String username,
    required String email,
    required String password,
    required double latitude,
    required double longitude,
    required int phonenum,
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
    required double latitude,
    required double longitude,
    required String accessToken,
  }) async {
    return apiClient.getHotSpotZones(
      latitude: latitude,
      longitude: longitude,
      accessToken: accessToken,
    );
  }

  Future getRoutes({
    required Marker origin,
    required Marker destination,
    required String accessToken,
  }) async {
    return apiClient.getRoutes(
      origin: origin,
      destination: destination,
      accessToken: accessToken,
    );
  }

  Future searchRoute({
    required String route,
    required LocationData origin,
    required String accessToken,
  }) {
    return apiClient.searchRoute(
      route: route,
      origin: origin,
      accessToken: accessToken,
    );
  }
}
