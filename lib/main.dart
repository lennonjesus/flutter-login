import 'package:flutter/material.dart';
import 'package:flutter_login/auth/auth-state.dart';
import 'package:flutter_login/bloc/AuthenticationBloc.dart';
import 'package:flutter_login/screen/home/home.screen.dart';
import 'package:flutter_login/screen/login/login.screen.dart';
import 'package:flutter_login/service/auth-service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login with Bloc',
      home: RootPage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class RootPage extends StatefulWidget {
  @override
  _RootPage createState() => _RootPage();
}

class _RootPage extends State<RootPage> {
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();

    Future<AuthState> authState = _authService.isAuthenticated();

    authState.then((authState) => authBloc.authEvent.add(authState));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: authBloc.authFlux,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.data == AuthState.LOGGED_IN
            ? HomeScreen()
            : LoginScreen();
      },
    );
  }
}
