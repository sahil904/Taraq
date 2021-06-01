import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/opertaion_list_response.dart';
import 'package:test/model/opertiaon_add_response.dart';
import 'package:test/repositry/operation_repository.dart';

import '../base/base_bloc.dart';

class OperationBloc extends BaseBloc {
  OperationBloc(BuildContext context) {
    onInit(context);
  }

  OperationRepository operationRepository;

  final _deleteLoader = BehaviorSubject<bool>();
  final _onOperationListSuccessBS = BehaviorSubject<List<DataOpertaion>>();
  final _onOperationAddSuccessBS = BehaviorSubject<OperationResponse>();

  Stream<List<DataOpertaion>> get onOperationListSuccess => _onOperationListSuccessBS.stream;

  Stream<OperationResponse> get onOperationAddSuccess => _onOperationAddSuccessBS.stream;

  Stream<bool> get onDeleteLoader => _deleteLoader.stream;

  List<DataOpertaion> operationList;
  @override
  void onInit(BuildContext context) {
    operationRepository = OperationRepository(context);
  }

  @override
  void onDispose() {
    compositeSubscription.clear();
    super.onDispose();
  }


  void deleteOperationListRequest(int addressId) {
    _deleteLoader.add(true);
    compositeSubscription
        .add(operationRepository.deleteOperationRequest(addressId).listen((response) {
      _deleteLoader.add(false);
      if (response is OperationListResponse) {
        //  updateAddressList(response.data, false);
        final int index = operationList.indexWhere((element) => element.id == addressId);
        operationList.removeAt(index);
        _onOperationListSuccessBS.add(operationList);
      }
      else {
        _onOperationListSuccessBS.addError(response);
      }
    }));
  }

  void updateOperationList(DataOpertaion detail, bool isAddressUpdated) {
    if (operationList != null && detail != null) {
      final int index = operationList.indexWhere((element) => element.id == detail.id);
      if (isAddressUpdated)
        operationList[index] = detail;
      else
        operationList.removeAt(index);
    }
    _onOperationListSuccessBS.add(operationList);
  }

  void operationListRequest() {
    isLoadingBS.add(true);
    compositeSubscription.add(operationRepository.operationListRequest().listen((response) {
      isLoadingBS.add(false);
      if (response is OperationListResponse) {
        operationList = response.data;
        _onOperationListSuccessBS.add(operationList);
      } else {
        _onOperationListSuccessBS.addError(response);
      }
    }));
  }

  void requestCreateOperation(String name) {
    isLoadingBS.add(true);
    compositeSubscription.add(operationRepository.requestCreateOperation(name).listen((response) {
      isLoadingBS.add(false);
      if (response is OperationResponse) {
        if (operationList != null)
          operationList.add(response.data);
        else {
          operationList = [];
          operationList.add(response.data);
        }
        _onOperationAddSuccessBS.add(response);
        _onOperationListSuccessBS.add(operationList);
      } else {
        _onOperationAddSuccessBS.addError(response);
      }
    }));
  }

  void updateOperationDetails(String request, int clientId) {
    isLoadingBS.add(true);
    compositeSubscription
        .add(operationRepository.updateOperationDetails(request, clientId).listen((response) {
      isLoadingBS.add(false);
      if (response is OperationResponse) {
        updateOperationList(response.data, true);
        _onOperationAddSuccessBS.add(response);
      } else {
        _onOperationAddSuccessBS.addError(response);
      }
    }));
  }
}
