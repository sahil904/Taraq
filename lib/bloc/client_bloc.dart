import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/model/client_add_response.dart';
import 'package:test/model/client_list_response.dart';
import 'package:test/model/login_response.dart';
import 'package:test/repositry/client_repository.dart';
import 'package:test/repositry/login_repository.dart';
import 'package:test/repositry/operation_repository.dart';

import '../base/base_bloc.dart';

class ClientBloc extends BaseBloc {
  ClientBloc(BuildContext context) {
    onInit(context);
  }

  ClientRepository _clientRepository;
  final _deleteLoader = BehaviorSubject<bool>();
  final _onClientListSuccessBS = BehaviorSubject<List<DataClient>>();
  final _onClientAddSuccessBS = BehaviorSubject<ClientAddResponse>();

  Stream<List<DataClient>> get onClientListSuccess => _onClientListSuccessBS.stream;

  Stream<ClientAddResponse> get onClientAddSuccess => _onClientAddSuccessBS.stream;

  Stream<bool> get onDeleteLoader => _deleteLoader.stream;

  List<DataClient> addressList;

  @override
  void onInit(BuildContext context) {
    _clientRepository = ClientRepository(context);
  }

  @override
  void onDispose() {
    compositeSubscription.clear();
    super.onDispose();
  }

  void deleteClientListRequest(int addressId) {
    _deleteLoader.add(true);
    compositeSubscription
        .add(_clientRepository.deleteClientListRequest(addressId).listen((response) {
      _deleteLoader.add(false);
      if (response is ClientListResponse) {
        //  updateAddressList(response.data, false);
        final int index = addressList.indexWhere((element) => element.id == addressId);
        addressList.removeAt(index);
        _onClientListSuccessBS.add(addressList);
      }
    }));
  }

  void updateAddressList(DataClient detail, bool isAddressUpdated) {
    if (addressList != null && detail != null) {
      final int index = addressList.indexWhere((element) => element.id == detail.id);
      if (isAddressUpdated)
        addressList[index] = detail;
      else
        addressList.removeAt(index);
    }
    _onClientListSuccessBS.add(addressList);
  }

  void clientListRequest() {
    isLoadingBS.add(true);
    compositeSubscription.add(_clientRepository.clientListRequest().listen((response) {
      isLoadingBS.add(false);
      if (response is ClientListResponse) {
        addressList = response.data;
        _onClientListSuccessBS.add(addressList);
      } else {
        _onClientListSuccessBS.addError(response);
      }
    }));
  }

  void requestCreateClient(String name) {
    isLoadingBS.add(true);
    compositeSubscription.add(_clientRepository.requestCreateClient(name).listen((response) {
      isLoadingBS.add(false);
      if (response is ClientAddResponse) {
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
  }
}
