import 'package:flutter_login/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  SharedPreferences _prefs;

  void save(User user) async {
    _prefs = await SharedPreferences.getInstance();

    _prefs.setString('auth_token', user.token);
    _prefs.setString('name', user.name);
  }

  Future<User> getUser() async {
    _prefs = await SharedPreferences.getInstance();

    String name = _prefs.getString('name');

    return User(name);
  }
}
