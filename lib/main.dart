import 'package:cloud_firebase_app/Cloud%20Storage/FirebaseCloudDb/signup_page.dart';
import 'package:cloud_firebase_app/Firebase_Database/firebase_add_db/firebase_add_data.dart';
import 'package:cloud_firebase_app/Firebase_Database/firebase_db/show_data.dart';
import 'package:cloud_firebase_app/View/Auth/Login/check_user.dart';
import 'package:cloud_firebase_app/View/PhoneAuth/phone_auth.dart';
import 'package:cloud_firebase_app/View/Splash/splash_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// database create the db connection
  // final FirebaseFirestore db = FirebaseFirestore.instance;
  // final CollectionReference college = db.collection('college');
  // final Map<String, dynamic> userFields = {
  //   'email' : 'newUser@gmail.com',
  //   'username' : 'newUser',
  // };
  // await college.doc('newUser').set(userFields);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      home: CheckUser(),
      // home: PhoneAuth(), // through the firebase otp
      // home : ShowData(), // fetch data through firebase firestore
      // home : SignUpPage(),
      //

    );
  }
}
