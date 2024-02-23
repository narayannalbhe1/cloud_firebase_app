import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:cloud_firebase_app/View/Auth/Widgets/ui_helper.dart';
import 'package:cloud_firebase_app/View/Home/view/MyHome/MyHomePage.dart';
import 'package:cloud_firebase_app/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  // final FirebaseAuth _auth = FirebaseAuth.instance;

   signIn(String email, String password) async{
    if(email == "" && password==""){
      Fluttertoast.showToast(msg: 'enter required fields');
    }
    else{
      UserCredential? usercredential;
        usercredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
        MyHomePage(),));
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset('assets/images/img.png',
          width: double.infinity,
          height: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white38
                ),
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Sign Up',style: TextStyle(fontSize: 20,color: Colors.black),),
                    SizedBox(height: 40),
                    UiHelper.customTextField(
                      controller: email,
                      hintText: "Emaill",
                      icon: Icon(Icons.email_outlined),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),

                    UiHelper.customTextField(
                      controller: password,
                      hintText: "Password",
                      icon: Icon(Icons.password),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 50),
                    UiHelper.RoundButton((){
                      signIn(email.text.toString(),password.text.toString());
                    },"Sign Up"),
                    Row(
                      mainAxisAlignment:MainAxisAlignment.end ,
                      children: [
                        Text('Already Have an Account ?'),
                        TextButton(
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return LoginScreen();
                              }));
                            }, child: Text('Login',style: TextStyle(color: Colors.deepPurple),))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
