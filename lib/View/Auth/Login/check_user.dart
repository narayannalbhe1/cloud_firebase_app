import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:cloud_firebase_app/View/Home/view/MyHome/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return checkUser();
  }

  checkUser(){
    final user = FirebaseAuth.instance.currentUser;
    if(user!=null){
      return MyHomePage();
    }else{
      return LoginScreen();
    }
  }

}
