import 'package:mobile_final/helpers/custom_text.dart';
import 'package:mobile_final/helpers/screen_navigation.dart';
import 'package:mobile_final/screens/dashboard.dart';
import 'package:mobile_final/screens/login.dart';
import 'package:mobile_final/screens/start.dart';
import 'package:flutter/material.dart';
import 'helpers/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static var isLogged = false;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: globals.currUser != null ? Dashboard() : Login(),
    );
  }
}




