import 'package:flutter/material.dart';
import 'package:flutter_login/auth/auth-state.dart';
import 'package:flutter_login/bloc/AuthenticationBloc.dart';
import 'package:flutter_login/service/auth-service.dart';
import 'package:flutter_login/service/user-service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthService _authService = AuthService();
  UserService _userService = UserService();
  String _username;

  @override
  initState() {
    super.initState();

    _userService.getUser().then((user) {
      setState(() {
        _username = user.name;
      });
    });
  }

  _logout() async {
    _authService.doLogout();
    authBloc.authEvent.add(AuthState.LOGGED_OUT);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
              ),
              onPressed: () => _logout(),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[Icon(Icons.thumb_up), Text('Hello, $_username')],
          ),
        ));
  }
}
