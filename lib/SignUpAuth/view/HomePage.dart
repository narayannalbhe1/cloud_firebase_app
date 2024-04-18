import 'package:cloud_firebase_app/SignUpAuth/auth/SignUpAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, User? user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User? _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn.signOut();
    // Navigator.pushReplacementNamed(context, '/signup');
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return SignUpAuth();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Home Screen'),
        actions: [
          IconButton(
            onPressed: _signOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Home Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _user != null
                ? Column(
                    children: [
                      Text(
                        'Signed in as: ${_user!.displayName}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email: ${_user!.email}',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 10),
                      _user!.photoURL != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(_user!.photoURL!),
                              radius: 40,
                            )
                          : SizedBox(),
                    ],
                  )
                : Text(
                    'User not signed in',
                    style: TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}
