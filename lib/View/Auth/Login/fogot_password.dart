import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:cloud_firebase_app/View/Auth/Widgets/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Forgot Password'),centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
         children: [
           UiHelper.customTextField(
             controller: emailController,
             hintText: "Enter your email address",
             icon: Icon(Icons.email_outlined,color: Colors.deepPurple),
             keyboardType: TextInputType.emailAddress,
             validator: (value) {
               if (value == null || value.isEmpty) {
                 return 'Please enter your Email';
               }
               return null;
             },
           ),
           SizedBox(height: 20),
           UiHelper.RoundButton((){
             forgotPassword(emailController.text.toString(),);
           },"Forgot password"),

         ],
      ),
    );
  }
  forgotPassword(String emailController) async{
    if(emailController==""){
      return Fluttertoast.showToast(msg: 'Enter an Email to reset password');
    }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailController);
      Fluttertoast.showToast(msg: 'Sent reset password link to your email address');
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LoginScreen();
      }));

    }
  }

}
