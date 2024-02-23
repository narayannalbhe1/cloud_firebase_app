import 'dart:io';

import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        automaticallyImplyLeading: false,
        title: Text('Home Page'),
      actions: [
        IconButton(onPressed: (){
         return Logout();
        }, icon: Icon(Icons.logout))
      ],
      ),
      body: WillPopScope(
        onWillPop: () {
          return  showAlertExit();
        },
        child: Center(
          child: Text('My Home Page'),
        ),
      ),
    );
  }

  Logout(){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Logout Account'),
        content: Text('Are you sure you want to log out?'),
        actions: [
          Container(
            width: 70,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.deepPurple
            ),
            padding: EdgeInsets.all(5.0),
            child: TextButton(
              onPressed: () {

                FirebaseAuth.instance.signOut();
                Fluttertoast.showToast(msg: 'Logout Successfully');
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
                // Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Logout',style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            width: 70,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.deepPurple
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      );
    });
  }

  showAlertExit(){
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Exit App'),
        content: Text('Are you sure on to exit app ?'),
        actions: [
          Container(
            width: 70,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.deepPurple
            ),
            padding: EdgeInsets.all(5.0),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                exit(0);
              },
              child: Text('Yes',style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            width: 70,
            height: 45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.deepPurple
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No',style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      );
    });
  }
}
