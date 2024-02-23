import 'package:cloud_firebase_app/View/Auth/Login/check_user.dart';
import 'package:cloud_firebase_app/View/PhoneAuth/phone_auth.dart';
import 'package:cloud_firebase_app/View/Splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // home: SplashScreen(),
      // home: CheckUser(),
      home: PhoneAuth(),
    );
  }
}
