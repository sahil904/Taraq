import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/base/base_repository.dart';
import 'package:test/model/error_response.dart';
import 'package:test/model/login_response.dart';
import 'package:test/network/api_controller.dart';
import 'package:test/utils/constants.dart';

class LoginRepository extends BaseRepository {
  LoginRepository(BuildContext context) {
    mContext = context;
    _apiController = APIController();
  }

  APIController _apiController;

  Stream<dynamic> loginRequest(
    String email,
    String password,
  ) {
    return Stream.fromFuture(Future.value(_apiController.loginRequest(
      this,
      email,
      password,
    )));
  }

  @override
  dynamic onSuccess(String endPoint, Response response) {
    super.onSuccess(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_LOGIN:
        return LoginResponse.fromJson(response.data);
    }
  }

  @override
  dynamic onError(String endPoint, ErrorResponse response) {
    super.onError(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_LOGIN:
        break;
    }

    return response;
  }
}
