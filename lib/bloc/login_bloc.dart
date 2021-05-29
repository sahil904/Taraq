import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test/model/login_response.dart';
import 'package:test/repositry/login_repository.dart';

import '../base/base_bloc.dart';

class LoginBloc extends BaseBloc {
  LoginBloc(BuildContext context) {
    onInit(context);
  }

  LoginRepository _loginRepository;

  final _onLoginSuccessBS = BehaviorSubject<LoginResponse>();

  Stream<LoginResponse> get onLoginSuccess => _onLoginSuccessBS.stream;

  @override
  void onInit(BuildContext context) {
    _loginRepository = LoginRepository(context);
  }

  @override
  void onDispose() {
    compositeSubscription.clear();
    super.onDispose();
  }

  void loginRequest(String email, String password) {
    isLoadingBS.add(true);
    compositeSubscription
        .add(_loginRepository.loginRequest(email, password).listen((loginOtpResponse) {
      isLoadingBS.add(false);
      if (loginOtpResponse is LoginResponse) {
        _onLoginSuccessBS.add(loginOtpResponse);
      } else {
        _onLoginSuccessBS.addError(LoginResponse);
      }
    }));
  }
}
