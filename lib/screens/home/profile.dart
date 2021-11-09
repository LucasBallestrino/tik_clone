import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tik_clone/screens/auth/login.dart';
import 'package:tik_clone/screens/auth/register.dart';
import 'package:tik_clone/utils/dialog_utils.dart';

///This screen was named profile, but It maybe named differently

class ProfileScreen extends StatefulWidget {
  final bool upload;
  const ProfileScreen({Key? key, required this.upload}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            "Perfil",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person_outline,
              size: 70,
              color: Colors.grey,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Center(
                child: widget.upload
                    ? Text("Regístrate para subir videos")
                    : Text("Regístrate para tener tu cuenta"),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              height: 50,
              child: Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.pink),
                  onPressed: () {
                    DialogUtils.showBottomModalSheet(context, registerForm());
                  },
                  child: Text("Registrarse"),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget registerForm() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(40),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Regístrate en TikTok",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Crea un perfil, sigue otras cuentas, graba tus propios videos y más.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.black,
                        ),
                        Expanded(
                          child: AutoSizeText(
                            "Usar número de teléfono o correo electrónico",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    child: Row(
                      children: [],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: 40,
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              Container(
                width: 40,
              ),
            ],
          ),
          Container(
            height: 50,
            child: Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "¿Ya tienes cuenta?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Iniciar sesión",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            color: Color.fromARGB(255, 220, 220, 220),
          )
        ],
      ),
    );
  }
}
