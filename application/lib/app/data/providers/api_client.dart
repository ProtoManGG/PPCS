import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../services/services.dart';
import '../models/failure_model.dart';

class ApiClient {
  final _api = ApiService().instance;

  Future login({@required String email, @required String password}) async {
    return _postRequestSender(
      path: '/login',
      data: {
        "email": email, //! Encrypt
        "password": password,
      },
    );
  }

  Future signUp({
    @required String username,
    @required String email,
    @required String password,
    @required double latitude,
    @required double longitude,
    @required int phonenum,
  }) async {
    return _postRequestSender(
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
  }

  Future getHotSpotZones({
    @required double latitude,
    @required double longitude,
    @required String accessToken,
  }) async {
    return _postRequestSender(
      path: '/covid',
      data: {
        "lat": latitude,
        "longi": longitude,
        "access_token": accessToken,
      },
    );
  }

  Future _postRequestSender({
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
