import 'package:flutter/material.dart';
import 'package:tik_clone/models/user/user.dart';
import 'package:tik_clone/screens/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tik_clone/services/auth.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(      
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'TikClone',
        theme: ThemeData(
          textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.pink) ,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.pink,
            ),
          ),
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(
                color: Colors.pink,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.pink,
                ),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.pink,
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(primary: Colors.pink),
            ),
            buttonTheme: ButtonThemeData(
              buttonColor: Colors.pink,
            )),
        home: HomeScreen(),
      ),
    );
  }
}
