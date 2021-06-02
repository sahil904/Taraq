import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test/model/error_response.dart';
import 'package:test/repositry/client_repository.dart';
import 'package:test/repositry/login_repository.dart';
import 'package:test/repositry/operation_repository.dart';
import 'package:test/repositry/project_repository.dart';

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

  void _prepareRequest() {
    final BaseOptions dioOptions = BaseOptions(
      connectTimeout: KGlobal.CONNECT_TIMEOUT,
      receiveTimeout: KGlobal.RECEIVE_TIMEOUT,
    )
      ..baseUrl = baseUrl
      ..contentType = Headers.jsonContentType
      ..headers[KReqHeaders.PLATFORM] = Platform.operatingSystem.toUpperCase();

    if (Utils.isNotEmpty(PrefUtils.getDevicesId()))
      dioOptions.headers[KReqHeaders.AUTHORIZATION] = PrefUtils.getDevicesId();
    debugPrint('TOKEN -> ' + PrefUtils.getDevicesId());

    _dio = Dio(dioOptions);
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      // Do something before request is sent
      options.headers["Authorization"] = "Bearer " + PrefUtils.getDevicesId();
      return options;
    }, onResponse: (Response response) {
      // Do something with response data
      return response; // continue
    }, onError: (DioError error) async {
      // Do something with response error
      if (error.response?.statusCode == 403) {
        _dio.interceptors.requestLock.lock();
        _dio.interceptors.responseLock.lock();
        RequestOptions options = error.response.request;
        // FirebaseUser user = await FirebaseAuth.instance.currentUser();
        //token = await user.getIdToken(refresh: true);
        //await writeAuthKey(token);
        options.headers["Authorization"] = "Bearer " + PrefUtils.getDevicesId();

        _dio.interceptors.requestLock.unlock();
        _dio.interceptors.responseLock.unlock();
        return _dio.request(options.path, options: options);
      } else {
        return error;
      }
    }));
    _dio.interceptors.add(
      LogInterceptor(responseBody: true),
    );
  }

  /* More customisable than prepareRequest() method.
   * Add your custom headers, if required. */
  // ignore: unused_element
  void _prepareCustomRequest(ContentType contentType, String baseUrl,
      Map<String, dynamic> customHeaders, bool isAuthorised) {
    //Sending these headers in every case.
    customHeaders.putIfAbsent(KReqHeaders.DEVICE_TYPE, () => Platform.operatingSystem);
    /*customHeaders.putIfAbsent(
        KReqHeaders.APP_VERSION, () async => await KGlobal.APP_VERSION);*/

    final BaseOptions dioOptions = BaseOptions(
      connectTimeout: KGlobal.CONNECT_TIMEOUT,
      receiveTimeout: KGlobal.RECEIVE_TIMEOUT,
    )
      ..baseUrl = baseUrl
      ..contentType = Headers.jsonContentType
      ..headers = customHeaders;
    if (isAuthorised && Utils.isNotEmpty(PrefUtils.getDevicesId()))
      dioOptions.headers[KReqHeaders.AUTHORIZATION] = PrefUtils.getDevicesId();

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

  Future<dynamic> clientListRequest(
    ClientRepository _repository,
  ) async {
    try {
      final Response response = await _dio.get(
        KApiEndPoints.API_CLIENT_LIST,
      );
      return _repository.onSuccess(
        KApiEndPoints.API_CLIENT_LIST,
        response,
      );
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_CLIENT_LIST, _handleError(e));
    }
  }

  Future<dynamic> deleteClientListRequest(ClientRepository _repository, int clientId) async {
    final String url = '${KApiEndPoints.API_CLIENT_LIST}/$clientId';
    try {
      final Response response = await _dio.delete(
        url,
      );
      return _repository.onSuccess(
        KApiEndPoints.API_DELETE_LIST,
        response,
      );
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_DELETE_LIST, _handleError(e));
    }
  }

  Future<dynamic> requestCreateClient(ClientRepository _repository, String name) async {
    // final String url = '${KApiEndPoints.API_CLIENT_LIST}/$name';

    FormData formData = new FormData.fromMap({'client_name': name});
    try {
      final Response response = await _dio.post(KApiEndPoints.API_CLIENT_LIST, data: formData);
      return _repository.onSuccess(
        KApiEndPoints.API_CREATE_CLIENT,
        response,
      );
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_CREATE_CLIENT, _handleError(e));
    }
  }

  Future<dynamic> updateClientDetails(
      ClientRepository _repository, int clientId, String name) async {
    final String url = '${KApiEndPoints.API_CLIENT_LIST}/$clientId';
    FormData formData = new FormData.fromMap({'client_name': name});

    try {
      final Response response = await _dio.post(url, data: formData);
      return _repository.onSuccess(KApiEndPoints.API_CLIENT_UPDATE, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_CLIENT_UPDATE, _handleError(e));
    }
  }

  Future<dynamic> deleteOperationRequest(OperationRepository _repository, int clientId) async {
    final String url = '${KApiEndPoints.API_OPERATION_LIST}/$clientId';
    try {
      final Response response = await _dio.delete(
        url,
      );
      return _repository.onSuccess(
        KApiEndPoints.API_OPERATION_DELETE,
        response,
      );
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_OPERATION_DELETE, _handleError(e));
    }
  }

  Future<dynamic> requestCreateOperation(OperationRepository _repository, String name) async {
    // final String url = '${KApiEndPoints.API_CLIENT_LIST}/$name';

    FormData formData = new FormData.fromMap({'operation_name': name});
    try {
      final Response response = await _dio.post(KApiEndPoints.API_OPERATION_LIST, data: formData);
      return _repository.onSuccess(KApiEndPoints.API_OPERATION_CREATE, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_OPERATION_CREATE, _handleError(e));
    }
  }

  Future<dynamic> updateOperationDetails(
      OperationRepository _repository, int clientId, String name) async {
    final String url = '${KApiEndPoints.API_OPERATION_LIST}/$clientId';
    FormData formData = new FormData.fromMap({'operation_name': name});

    try {
      final Response response = await _dio.post(url, data: formData);
      return _repository.onSuccess(KApiEndPoints.API_OPERATION_UPDATE, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_OPERATION_UPDATE, _handleError(e));
    }
  }

  Future<dynamic> operationListRequest(
    OperationRepository _repository,
  ) async {
    try {
      final Response response = await _dio.get(
        KApiEndPoints.API_OPERATION_LIST,

        //HttpHeaders.authorizationHeader: "Bearer $token"
      );
      return _repository.onSuccess(KApiEndPoints.API_OPERATION_LIST, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_OPERATION_LIST, _handleError(e));
    }
  }

  Future<dynamic> projectListRequest(
    ProjectRepository _repository,
  ) async {
    try {
      final Response response = await _dio.get(
        KApiEndPoints.API_PROJECT_LIST,

        //HttpHeaders.authorizationHeader: "Bearer $token"
      );
      return _repository.onSuccess(KApiEndPoints.API_PROJECT_LIST, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_PROJECT_LIST, _handleError(e));
    }
  }


  Future<dynamic> requestCreateProject(
      ProjectRepository _repository, String name, File photo) async {
    final String url = '${KApiEndPoints.API_PROJECT_LIST}';
    String fileName;
    if (photo != null) {
      fileName = photo.path.split('/').last;
    }
    FormData formData = new FormData.fromMap(
      {
        'project_name': name,
        'image': photo == null ? "" : await MultipartFile.fromFile(photo.path, filename: fileName),
      },
    );
    try {
      final Response response = await _dio.post(url, data: formData);
      return _repository.onSuccess(KApiEndPoints.API_PROJECT_CREATE, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_PROJECT_CREATE, _handleError(e));
    }
  }

  Future<dynamic> deleteProjectRequest(ProjectRepository _repository, int id) async {
    final String url = '${KApiEndPoints.API_PROJECT_LIST}/$id';
    try {
      final Response response = await _dio.delete(url);
      return _repository.onSuccess(KApiEndPoints.API_PROJECT_DELETE, response);
    } on DioError catch (e) {
      return _repository.onError(KApiEndPoints.API_PROJECT_DELETE, _handleError(e));
    }
  }
    Future<dynamic> transcationRequest(
        ProjectRepository _repository,int projectId,String clientId,String operationId,String price,
        String date,String notes
        ) async {
      FormData formData = new FormData.fromMap({
        'project_id': projectId,
        'client_id': clientId,
        'operation_id': operationId,
        'price': price,
        'date': date,
        'notes': notes,

      });
      try {
        final Response response = await _dio.get(
          KApiEndPoints.API_TRANSACTION,

          //HttpHeaders.authorizationHeader: "Bearer $token"
        );
        return _repository.onSuccess(KApiEndPoints.API_TRANSACTION, response);
      } on DioError catch (e) {
        return _repository.onError(KApiEndPoints.API_TRANSACTION, _handleError(e));
      }

  }
}
