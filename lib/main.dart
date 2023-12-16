import 'package:flutter/material.dart';
import 'modules/apartamentos/home_screen.dart';
import 'modules/login/login_screen.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) =>  LoginScreen());
          case '/home':
            return MaterialPageRoute(builder: (_) =>  HomeScreen());
          case '/login':
            return MaterialPageRoute(builder: (_) =>  LoginScreen());
          default:
            return MaterialPageRoute(builder: (_) =>  LoginScreen());
        }
      },
    );
  }
}

