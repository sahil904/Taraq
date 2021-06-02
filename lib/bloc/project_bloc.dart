import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/delete_response.dart';
import 'package:test/model/project_add_response.dart';
import 'package:test/model/project_list_response.dart';
import 'package:test/model/transcation_add_response.dart';
import 'package:test/repositry/project_repository.dart';

import '../base/base_bloc.dart';

class ProjectBloc extends BaseBloc {
  ProjectBloc(BuildContext context) {
    onInit(context);
  }

  ProjectRepository _projectRepository;
  final _deleteLoader = BehaviorSubject<bool>();
  final _onClientListSuccessBS = BehaviorSubject<List<DataProject>>();
  final _onClientAddSuccessBS = BehaviorSubject<ProjectAddResponse>();
  final _onTransactionAddSuccessBS = BehaviorSubject<TranscationResponse>();
  final _onProjectDeleteSuccessBS = BehaviorSubject<DeletedResponse>();

  Stream<List<DataProject>> get onProjectListSuccess => _onClientListSuccessBS.stream;

  Stream<ProjectAddResponse> get onProjectAddSuccess => _onClientAddSuccessBS.stream;
  Stream<TranscationResponse> get onTransactionAddSuccess => _onTransactionAddSuccessBS.stream;
  Stream<DeletedResponse> get onProjectDeleteSuccess => _onProjectDeleteSuccessBS.stream;

  Stream<bool> get onDeleteLoader => _deleteLoader.stream;

  List<DataProject> addressList;

  @override
  void onInit(BuildContext context) {
    _projectRepository = ProjectRepository(context);
  }

  @override
  void onDispose() {
    compositeSubscription.clear();
    _onClientListSuccessBS.close();
    _onClientAddSuccessBS.close();
    _onProjectDeleteSuccessBS.close();
    super.onDispose();
  }

  void deleteProjectRequest(int addressId) {
    _deleteLoader.add(true);
    compositeSubscription
        .add(_projectRepository.deleteProjectRequest(addressId).listen((response) {
     // _deleteLoader.add(false);
      if (response is ProjectListResponse) {
        //  updateAddressList(response.data, false);
      // final int index = addressList.indexWhere((element) => element.id == addressId);
      //  addressList.removeAt(index);
        //_onProjectDeleteSuccessBS.add(response);
print("onDeleteLoader"+"sucess");
        _onClientListSuccessBS.add(addressList);
      } else {
        _onClientListSuccessBS.addError(response);
      }
    }));
  }

/*  void updateAddressList(DataClient detail, bool isAddressUpdated) {
    if (addressList != null && detail != null) {
      final int index = addressList.indexWhere((element) => element.id == detail.id);
      if (isAddressUpdated)
        addressList[index] = detail;
      else
        addressList.removeAt(index);
    }
    _onClientListSuccessBS.add(addressList);
  }*/

  void projectListRequest() {
    isLoadingBS.add(true);
    compositeSubscription.add(_projectRepository.projectListRequest().listen((response) {
      isLoadingBS.add(false);
      if (response is ProjectListResponse) {
        addressList = response.data;
        _onClientListSuccessBS.add(addressList);
      } else {
        _onClientListSuccessBS.addError(response);
      }
    }));
  }

  void transcationRequest(int projectId,String clientId,String operationId,String price,
      String date,String notes) {
    isLoadingBS.add(true);
    compositeSubscription.add(_projectRepository.transcationRequest(projectId,clientId,
      operationId,price,date,notes).listen(
            (response) {
      isLoadingBS.add(false);
      if (response is TranscationResponse) {
        _onTransactionAddSuccessBS.add(response);
      } else {
        _onTransactionAddSuccessBS.addError(response);
      }
    }));
  }

  void requestCreateProject(String name, File imageFile) {
    isLoadingBS.add(true);
    compositeSubscription.add(_projectRepository.requestCreateProject(name,imageFile).listen((response) {
      isLoadingBS.add(false);
      if (response is ProjectAddResponse) {
        if (addressList != null)
          addressList.add(response.data);
        else {
          addressList = [];
          addressList.add(response.data);
        }
        _onClientAddSuccessBS.add(response);
        _onClientListSuccessBS.add(addressList);
      } else {
        _onClientAddSuccessBS.addError(response);
      }
    }));
  }
/*
  void updateClientDetails(String request, int clientId) {
    isLoadingBS.add(true);
    compositeSubscription
        .add(_clientRepository.updateClientDetails(request, clientId).listen((response) {
      isLoadingBS.add(false);
      if (response is ClientAddResponse) {
       updateAddressList(response.data, true);
        _onClientAddSuccessBS.add(response);
      } else {
        _onClientAddSuccessBS.addError(response);
      }
    }));
  }*/
}
