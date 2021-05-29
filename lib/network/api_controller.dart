import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test/model/error_response.dart';
import 'package:test/repositry/login_repository.dart';

import 'package:test/res/strings.dart';
import 'package:test/utils/constants.dart';
import 'package:test/utils/pref_utils.dart';
import 'package:test/utils/utils.dart';
import 'dio_logger.dart';

class APIController {
  APIController() {
    _prepareRequest();
  }

  // ignore: non_constant_identifier_names
  APIController.CustomAPIController(ContentType contentType, String baseUrl,
      Map<String, dynamic> customHeaders, bool isAuthorised) {
    _prepareCustomRequest(contentType, baseUrl, customHeaders, isAuthorised);
  }

  static const TAG = 'APIController';
  static const baseUrl = KApiBase.BASE_URL;

  static const RESPONSE_TYPE_MULTIPART = 'multipart/form-data';
  static const RESPONSE_TYPE_ZIP = 'application/zip';

  Dio _dio;

  /* App wide general request.
   * For setting up custom request use the prepareCustomRequest() method. */
  void _prepareRequest() {
    final BaseOptions dioOptions = BaseOptions(
      connectTimeout: KGlobal.CONNECT_TIMEOUT,
      receiveTimeout: KGlobal.RECEIVE_TIMEOUT,
    )
      ..baseUrl = baseUrl
      ..contentType = Headers.jsonContentType
    //setting custom headers
    //sending device type in every request
      ..headers[KReqHeaders.AUTHORIZATION] = Platform.operatingSystem.toUpperCase();

    if (Utils.isNotEmpty(PrefUtils.getUserToken()))
      dioOptions.headers[KReqHeaders.AUTHORIZATION.toUpperCase()] = PrefUtils.getDevicesId();
    debugPrint('getDevicesId -> ' + PrefUtils.getDevicesId());

    _dio = Dio(dioOptions);
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  /* More customisable than prepareRequest() method.
   * Add your custom headers, if required. */
  // ignore: unused_element
  void _prepareCustomRequest(ContentType contentType, String baseUrl,
      Map<String, dynamic> customHeaders, bool isAuthorised) {
    //Sending these headers in every case.
    customHeaders.putIfAbsent(
        KReqHeaders.DEVICE_TYPE, () => Platform.operatingSystem);
    /*customHeaders.putIfAbsent(
        KReqHeaders.APP_VERSION, () async => await KGlobal.APP_VERSION);*/

    final BaseOptions dioOptions = BaseOptions(
      connectTimeout: KGlobal.CONNECT_TIMEOUT,
      receiveTimeout: KGlobal.RECEIVE_TIMEOUT,
    )
      ..baseUrl = baseUrl
      ..contentType = Headers.jsonContentType
      ..headers = customHeaders;
    // if (isAuthorised && Utils.isNotEmpty(Prefs.prefs.getString(KPrefs.TOKEN)))
    //   dioOptions.headers[KReqHeaders.DTYPE] = Prefs.prefs.getString(KPrefs.TOKEN);

    if (Utils.isNotEmpty(PrefUtils.getUserToken()))
      dioOptions.headers[KReqHeaders.AUTHORIZATION.toUpperCase()] = PrefUtils.getDevicesId();
    debugPrint('getDevicesId -> ' + PrefUtils.getDevicesId());

    _dio = Dio(dioOptions);
    // Add your own interceptors if you want to do something different from the regular flow.
    _addInterceptors();
  }


  /* Adding interceptors on requests and response to log them in console and
   * better handle successes and errors. */
  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      DioLogger.onSend(TAG, options);
      return options;
    }, onResponse: (Response response) {
      DioLogger.onSuccess(TAG, response);
      return response;
    }, onError: (DioError error) {
      DioLogger.onError(TAG, error);
      return _handleError(error);
    }));
  }

  ErrorResponse _handleError(DioError error) {
    String errorDescription = '';
    String customErrorCode = '';
    switch (error.type) {
      case DioErrorType.CANCEL:
        errorDescription = error_request_cancelled;
        break;
      case DioErrorType.RESPONSE:
        if (error.response != null && error.response.data != null) {
          try {
            ErrorResponse customError = ErrorResponse.fromJson(error.response.data);
            errorDescription = customError.error.message;
            customErrorCode = customError.error.customCode;
          } catch (e) {
            errorDescription = error_general;
          }
        }
        if (Utils.isEmpty(errorDescription)) errorDescription = error_general;
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        errorDescription = 'CONNECT_TIMEOUT : ${error.message}';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        errorDescription = 'RECEIVE_TIMEOUT : ${error.message}';
        break;
      case DioErrorType.SEND_TIMEOUT:
        errorDescription = 'SEND_TIMEOUT : ${error.message}';
        break;
      case DioErrorType.DEFAULT:
        errorDescription = error_request_timeout + error.message;
        break;
    }
    final ErrorResponse errorResponse = ErrorResponse(
        statusCode: error.response != null
            ? error.response.statusCode
            /* Ideally the status code should be STATUS_REQUEST_TIME_OUT when internet is not connected
             * and STATUS_SERVICE_UNAVAILABLE otherwise. But we aren't using them, so not making an additional
             * check for internet.*/
            : KApiResponseCodes.STATUS_SERVICE_UNAVAILABLE,
        error: Error(message: errorDescription, customCode: customErrorCode));
    return errorResponse;
  }

  ///********** API Calls ***************///

  ///****** Log In Flow ******///
  Future<dynamic> loginRequest(
    LoginRepository _repository,
    String email,
    String password,
  ) async {
    FormData formData = new FormData.fromMap({
      'email': email,
      'password': password,

      // 'Amount': amount,
      // 'Amount': amount,
    });

    try {
      final Response response = await _dio.post(KApiEndPoints.API_LOGIN, data: formData);
      return _repository.onSuccess(KApiEndPoints.API_LOGIN, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_LOGIN, _handleError(e));
    }
  }
}
