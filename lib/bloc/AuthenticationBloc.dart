import 'dart:async';

import 'package:flutter_login/auth/auth-state.dart';
import 'package:rxdart/rxdart.dart';

class AuthenticationBloc {
  BehaviorSubject<AuthState> _authController =
      new BehaviorSubject(seedValue: AuthState.LOGGED_OUT);

  StreamController get authController => _authController;

  Stream<AuthState> get authFlux => _authController.stream;

  StreamSink<AuthState> get authEvent => _authController.sink;

  AuthenticationBloc() {
    authFlux.listen((data) {
      print(data);
    });
  }

  void dispose() {
    _authController.close();
  }
}

AuthenticationBloc authBloc = new AuthenticationBloc();
