import 'package:flutter/material.dart';
import 'package:untitled1/login/login_page.dart';
import 'package:untitled1/signup/signup.dart';

void main() {
  // intialize the widgets
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CS 184 Final Project',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginDemo(),
        '/signup': (context) => SignUpDemo(),
      }
    );
  }


}
