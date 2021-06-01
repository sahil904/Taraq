import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/base/base_repository.dart';
import 'package:test/model/client_add_response.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/error_response.dart';
import 'package:test/network/api_controller.dart';
import 'package:test/utils/constants.dart';

class ClientRepository extends BaseRepository {
  ClientRepository(BuildContext context) {
    mContext = context;
    _apiController = APIController();
  }

  APIController _apiController;

  Stream<dynamic> clientListRequest() {
    return Stream.fromFuture(Future.value(_apiController.clientListRequest(
      this,
    )));
  }

  Stream<dynamic> deleteClientListRequest(int clientId) {
    return Stream.fromFuture(Future.value(_apiController.deleteClientListRequest(this, clientId)));
  }

  Stream<dynamic> requestCreateClient(String name) {
    return Stream.fromFuture(Future.value(_apiController.requestCreateClient(this, name)));
  }

  Stream<dynamic> updateClientDetails(String name,int clientId) {
    return Stream.fromFuture(Future.value(_apiController.updateClientDetails(this, clientId,name)));
  }

  @override
  dynamic onSuccess(String endPoint, Response response) {
    super.onSuccess(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_CLIENT_LIST:
      case KApiEndPoints.API_DELETE_LIST:
        return ClientListResponse.fromJson(response.data);
      case KApiEndPoints.API_CREATE_CLIENT:
      case KApiEndPoints.API_CLIENT_UPDATE:
        return ClientAddResponse.fromJson(response.data);
    }
  }

  @override
  dynamic onError(String endPoint, ErrorResponse response) {
    super.onError(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_CLIENT_LIST:
      case KApiEndPoints.API_DELETE_LIST:
      case KApiEndPoints.API_CREATE_CLIENT:
      case KApiEndPoints.API_CLIENT_UPDATE:
        break;
    }

    return response;
  }
}
