import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/base/base_repository.dart';
import 'package:test/model/error_response.dart';
import 'package:test/model/opertaion_list_response.dart';
import 'package:test/model/opertiaon_add_response.dart';
import 'package:test/network/api_controller.dart';
import 'package:test/utils/constants.dart';

class OperationRepository extends BaseRepository {
  OperationRepository(BuildContext context) {
    mContext = context;
    _apiController = APIController();
  }

  APIController _apiController;

  Stream<dynamic> operationListRequest() {
    return Stream.fromFuture(Future.value(_apiController.operationListRequest(
      this,
    )));
  }

  Stream<dynamic> deleteOperationRequest(int clientId) {
    return Stream.fromFuture(Future.value(_apiController.deleteOperationRequest(this, clientId)));
  }

  Stream<dynamic> requestCreateOperation(String name) {
    return Stream.fromFuture(Future.value(_apiController.requestCreateOperation(this, name)));
  }

  Stream<dynamic> updateOperationDetails(String name, int clientId) {
    return Stream.fromFuture(
        Future.value(_apiController.updateOperationDetails(this, clientId, name)));
  }

  @override
  dynamic onSuccess(String endPoint, Response response) {
    super.onSuccess(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_OPERATION_LIST:
      case KApiEndPoints.API_OPERATION_DELETE:
        return OperationListResponse.fromJson(response.data);
      case KApiEndPoints.API_OPERATION_CREATE:
      case KApiEndPoints.API_OPERATION_UPDATE:
        return OperationResponse.fromJson(response.data);
    }
  }

  @override
  dynamic onError(String endPoint, ErrorResponse response) {
    super.onError(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_OPERATION_LIST:
      case KApiEndPoints.API_OPERATION_UPDATE:
      case KApiEndPoints.API_OPERATION_DELETE:
      case KApiEndPoints.API_OPERATION_CREATE:
        break;
    }

    return response;
  }
}
