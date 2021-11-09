import 'package:flutter/material.dart';
import 'package:tik_clone/services/auth.dart';

/// Login screen

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthService _authService = AuthService();
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            "Login",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: _body(),
    );
  }

  /// The main content of the screen
  Widget _body() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Form(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Email"),
                controller: _email,
              ),
              Container(
                height: 20,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(labelText: "Contraseña"),
                controller: _pass,
              ),
              Container(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  dynamic result = await _authService.loginEmailAndPass(
                      _email.text, _pass.text);
                  if (result == null) {
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text("Login"),
              ),
              //TextField(decoration: InputDecoration(labelText: "Email"),),
              Container(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
