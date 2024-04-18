import 'dart:developer';
import 'dart:io';

import 'package:cloud_firebase_app/SignUpAuth/services/model.dart';
import 'package:cloud_firebase_app/SignUpAuth/view/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';


///twitter
// https://cloudfirebase-1f8fa.firebaseapp.com/__/auth/handler
///fb
//https://cloudfirebase-1f8fa.firebaseapp.com/__/auth/handler

class SignUpAuth extends StatefulWidget {
  const SignUpAuth({Key? key}) : super(key: key);

  @override
  State<SignUpAuth> createState() => _SignUpAuthState();
}

class _SignUpAuthState extends State<SignUpAuth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;

  Future<UserCredential?> _signInWithGoogle(BuildContext context) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


        final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

        if (googleAuth != null) {
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );

          return await FirebaseAuth.instance.signInWithCredential(credential);
        } else {
          log('Google authentication details not available.');
          Dialogs.showsnackbar(context, 'Google authentication failed.');
          return null;
        }
      } else {
        log('No internet connection.');
        Dialogs.showsnackbar(context, 'No internet connection.');
        return null;
      }
    } catch (e) {
      log('\n_signInWithGoogle: $e');
      Dialogs.showsnackbar(context, 'Error: $e');
      return null;
    }
  }

  // Future<void> _signInWithFacebook(BuildContext context) async {
  //   try {
  //     final LoginResult loginResult = await _facebookAuth.login();
  //     final AccessToken? accessToken = loginResult.accessToken;
  //     if (accessToken != null) {
  //       final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
  //       final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //       print('Signed in with Facebook: ${userCredential.user?.displayName}');
  //       // Navigate to the next screen or perform other actions
  //     }
  //   } catch (e) {
  //     print('Facebook sign-in error: $e');
  //   }
  // }

  Future<Resource?> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential =
          await _auth.signInWithCredential(facebookCredential);
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }


  Future<void> _signInWithTwitter() async {
    try {
      final TwitterAuthProvider twitterProvider = TwitterAuthProvider();
      final UserCredential userCredential =
      await _auth.signInWithPopup(twitterProvider);
      print('User signed in with Twitter: ${userCredential.user}');
    } catch (e) {
      print('Error signing in with Twitter: $e');
    }
  }
  void _navigateToHome(User? user) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(user: user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Sign Up Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/google-logo-9808.png',
                  height: 100,
                  width: 100,
                ),
                ElevatedButton(
                  onPressed: () async {
                    UserCredential? userCredential = await _signInWithGoogle(context);
                    if (userCredential != null) {
                      print('Signed in with Google: ${userCredential.user?.displayName}');
                      _navigateToHome(userCredential.user);
                    } else {
                      print('Google sign-in failed');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                  ),
                  child: Text('Sign In with Google'),
                ),
              ],
            ),
          ),

          SizedBox(height: 20), // Spacer between sections

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/facebook-logo-502.jpg',
                height: 50,
                width: 50,
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _signInWithFacebook();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
                child: Text('Sign In with Facebook'),
              ),
            ],
          ),

          SizedBox(height: 20), // Spacer between sections

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/twitter-x-logo-42562.png',
                height: 50,
                width: 50,
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  _signInWithTwitter();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.lightBlue,
                  onPrimary: Colors.white,
                ),
                child: Text('Sign In with Twitter'),
              ),
            ],
          ),

          SizedBox(height: 20), // Spacer between sections

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/png-apple-logo-9713.png',
                height: 50,
                width: 50,
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                 // _signInWithApple();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  onPrimary: Colors.white,
                ),
                child: Text('Sign In with Apple'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Dialogs {
  static void showsnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}