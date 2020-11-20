import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../services/api_service.dart';
import '../models/failure_model.dart';

class ApiClient {
  final _api = ApiService().instance;

  Future login({@required String email, @required String password}) async =>
      postRequestSender(
        path: '/login',
        data: {
          "email": email, //! Encrypt
          "password": password,
        },
      );

  Future signUp({
    @required String username,
    @required String email,
    @required String password,
    @required double latitude,
    @required double longitude,
    @required int phonenum,
  }) async =>
      postRequestSender(
        path: '/signup',
        data: {
          "username": username,
          "phone_no": phonenum,
          "email": email,
          "password": password,
          "lat": latitude,
          "longi": longitude
        },
      );

  Future postRequestSender({
    @required String path,
    @required Map<String, dynamic> data,
  }) async {
    try {
      final Response response = await _api.dio.post(
        path,
        data: data,
      );

      return response.data;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Failure(
          statusCode: e.response.statusCode,
          message: e.response.statusMessage,
        );
      } else {
        throw Failure(message: e.message);
      }
    }
  }
}
