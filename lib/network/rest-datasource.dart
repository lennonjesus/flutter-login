import 'dart:async';
import 'dart:io';

import 'package:flutter_login/model/user.dart';
import 'package:flutter_login/network/network-util.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "[YOUR_API]";
  static final LOGIN_URL = BASE_URL + "/login";
  static final _API_KEY = "[YOUR KEY]";

  Future<User> login(String username, String password) {
    var headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    var body = {"token": _API_KEY, "username": username, "password": password};

    return _netUtil
        .post(LOGIN_URL, body: body, headers: headers)
        .then((dynamic res) {
      print(res.toString());

      if (res["session_token"] == null) throw new Exception('Incorrect login!');

      return new User.map(res);
    });
  }
}
