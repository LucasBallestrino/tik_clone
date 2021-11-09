import 'package:flutter/material.dart';
import 'package:tik_clone/services/auth.dart';

/// The register screen

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  AuthService _authService = AuthService();
  TextEditingController _email = TextEditingController();
  TextEditingController _userName = TextEditingController();
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
            "Registrarse",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: _body(),
    );
  }

  ///Main content of the screen
  
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
                decoration: InputDecoration(labelText: "Nombre de usuario"),
                controller: _userName,
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
                  dynamic result =
                      await _authService.registerWithEmailAndPassword(
                          _email.text, _pass.text, "", _userName.text);
                  if (result == null) {
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text("Registrarse"),
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
