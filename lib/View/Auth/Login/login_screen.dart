import 'package:cloud_firebase_app/View/Auth/Login/fogot_password.dart';
import 'package:cloud_firebase_app/View/Auth/SignUp/signin_screen.dart';
import 'package:cloud_firebase_app/View/Auth/Widgets/ui_helper.dart';
import 'package:cloud_firebase_app/View/Home/view/MyHome/MyHomePage.dart';
import 'package:cloud_firebase_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();


  void _login() {
    if (_formKey.currentState!.validate()) {
      print('Username: ${email.text}');
      print('Password: ${password.text}');
    }
  }

  login(String email, String password) async{
    if(email == "" && password==""){
      Fluttertoast.showToast(msg: 'enter required fields');
    }
    else{
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        Fluttertoast.showToast(msg: 'Login Successfully');
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
            MyHomePage(),));
      } on FirebaseAuthException catch(ex){
        return Fluttertoast.showToast(msg: ex.code.toString());
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Login')),
      automaticallyImplyLeading: false,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

            UiHelper.customTextField(
              controller: email,
              hintText: "Email",
              icon: Icon(Icons.email_outlined),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
            ),

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
              SizedBox(height: 20),
              UiHelper.RoundButton((){
                login(email.text.toString(),password.text.toString());
              },"Login"),

              Row(
                mainAxisAlignment:MainAxisAlignment.end ,
                children: [
                  Text('Don\'t Have an Account ?'),
                  TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return SignInScreen();
                    }));
                  }, child: Text('Sign Up',style: TextStyle(color: Colors.deepPurple),)),

                ],
              ),
              SizedBox(height: 20),
              TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ForgotPassword();
                    }));
                  }, child: Text("Forgot Password??",style: TextStyle(
                  fontSize: 20,color: Colors.deepPurple
              ),)),
            ],
          ),
        ),
      ),
    );
  }
}


