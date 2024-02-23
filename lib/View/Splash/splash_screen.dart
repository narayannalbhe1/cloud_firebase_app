import 'dart:async';

import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:cloud_firebase_app/View/Auth/SignUp/signin_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


   goToScreen() {
    Timer(
      Duration(seconds: 2),
          () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignInScreen()),
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToScreen();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Icon(Icons.smart_display_sharp),
          Text('Cloud firebase'),
        ]),
      ),
    );
  }
}
