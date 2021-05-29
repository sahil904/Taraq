import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test/utils/utils.dart';
import 'package:test/model/error_response.dart';



abstract class BaseRepository {
  BuildContext mContext;

  dynamic onSuccess(String endPoint, Response response) {
    Utils.hideLoader();
  }

  dynamic onError(String endPoint, ErrorResponse response) {
    Utils.hideLoader();
    Utils.showValidationMessage(mContext, response.error.message);
    return response;
  }
}
