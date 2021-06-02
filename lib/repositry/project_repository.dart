import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/base/base_repository.dart';
import 'package:test/model/delete_response.dart';
import 'package:test/model/error_response.dart';
import 'package:test/model/project_add_response.dart';
import 'package:test/model/project_list_response.dart';
import 'package:test/model/transcation_add_response.dart';
import 'package:test/network/api_controller.dart';
import 'package:test/utils/constants.dart';

class ProjectRepository extends BaseRepository {
  ProjectRepository(BuildContext context) {
    mContext = context;
    _apiController = APIController();
  }

  APIController _apiController;

  Stream<dynamic> projectListRequest() {
    return Stream.fromFuture(Future.value(_apiController.projectListRequest(this)));
  }

  Stream<dynamic> transcationRequest(
      int projectId, String clientId, String operationId, String price, String date, String notes) {
    return Stream.fromFuture(Future.value(_apiController.transcationRequest(
        this, projectId, clientId, operationId, price, date, notes)));
  }

  Stream<dynamic> requestCreateProject(String name, File imageFile) {
    return Stream.fromFuture(
        Future.value(_apiController.requestCreateProject(this, name, imageFile)));
  }

  Stream<dynamic> deleteProjectRequest(int id) {
    return Stream.fromFuture(Future.value(_apiController.deleteProjectRequest(this, id)));
  }

  @override
  dynamic onSuccess(String endPoint, Response response) {
    super.onSuccess(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_PROJECT_LIST:
      case KApiEndPoints.API_PROJECT_DELETE:
        return ProjectListResponse.fromJson(response.data);
      case KApiEndPoints.API_PROJECT_CREATE:
        return ProjectAddResponse.fromJson(response.data);
        case KApiEndPoints.API_TRANSACTION:
        return TranscationResponse.fromJson(response.data);
    }
  }

  @override
  dynamic onError(String endPoint, ErrorResponse response) {
    super.onError(endPoint, response);
    switch (endPoint) {
      case KApiEndPoints.API_PROJECT_LIST:
      case KApiEndPoints.API_PROJECT_DELETE:
      case KApiEndPoints.API_PROJECT_CREATE:
      case KApiEndPoints.API_TRANSACTION:
        break;
    }

    return response;
  }
}
