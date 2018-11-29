import 'package:flutter_login/auth/auth-state.dart';
import 'package:flutter_login/bloc/AuthenticationBloc.dart';
import 'package:flutter_login/model/user.dart';
import 'package:flutter_login/network/rest-datasource.dart';
import 'package:flutter_login/service/user-service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  RestDatasource _api = new RestDatasource();
  UserService _userService = UserService();

  SharedPreferences _prefs;

  doLogin(String username, String password) {
    _api.login(username, password).then((User user) {
      _userService.save(user);
      authBloc.authEvent.add(AuthState.LOGGED_IN);
    }).catchError((Exception error) {
      print('ERROR -> $error');
      authBloc.authEvent.add(AuthState.LOGGED_OUT);
    });
  }

  doLogout() async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.remove('auth_token');
    _prefs.remove('name');
  }

  Future<AuthState> isAuthenticated() async {
    _prefs = await SharedPreferences.getInstance();

    String token = _prefs.getString('auth_token') ?? '';

    return token.isNotEmpty ? AuthState.LOGGED_IN : AuthState.LOGGED_OUT;
  }
}
