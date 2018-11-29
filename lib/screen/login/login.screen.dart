import 'package:flutter/material.dart';
import 'package:flutter_login/service/auth-service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;

  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  AuthService _authService;

  String _username;

  String _password;

  final formKey = GlobalKey<FormState>();

  _login() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() => _isLoading = true);

      form.save();

      _authService.doLogin(_username, _password);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  _LoginScreenState() {
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    var loginButton = RaisedButton(
        child: Text('Login'),
        onPressed: () => _login(),
        color: Colors.blue,
        textColor: Colors.white,
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))));

    return Scaffold(
      appBar: null,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/images/flutter-logo.png'),
                    height: 100,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    onSaved: (val) => _username = val,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        labelText: 'Username', hintText: 'Your username here'),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    onSaved: (val) => _password = val,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                        labelText: 'Password', hintText: 'Your password here'),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : loginButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
