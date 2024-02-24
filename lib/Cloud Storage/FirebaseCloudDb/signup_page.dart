
import 'dart:io';
import 'dart:math';

import 'package:cloud_firebase_app/View/Auth/Login/login_screen.dart';
import 'package:cloud_firebase_app/View/Auth/Widgets/ui_helper.dart';
import 'package:cloud_firebase_app/View/Home/view/MyHome/MyHomePage.dart';
import 'package:cloud_firebase_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  File? pickedImage;

  showAlertBox(){
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Pick Image From'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: (){
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              leading: Icon(Icons.camera_alt),
              title: Text('Camera'),
            ),
            ListTile(
            onTap:(){
              pickImage(ImageSource.gallery);
                 Navigator.pop(context);
            },
            leading: Icon(Icons.image),
              title: Text("Gallery"),
            ),
          ],
        ),
      );
    });
  }

  signUp(String email, String password) async{
    if(email=="" && password=="" && pickedImage==null){
      return showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          title: Text("Enter Required Field"),
          actions: [
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text('Ok'))
          ],
        );
      });
    }else{
      UserCredential? usercredential;
      try{
        usercredential = await FirebaseAuth.instance.
        createUserWithEmailAndPassword(
            email: email,
            password: password).then((value) {
              uploadData();
        });
        }
        on FirebaseAuthException catch(ex){
         log(ex.code.toString() as num);
      }
    }
  }

  uploadData() async{
    UploadTask uploadTask = FirebaseStorage.instance.
    ref("Profile Pics")
        .child(email.text.toString()).putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask ;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("User").doc(
      email.text.toString()).set({
      "Email":email.text.toString(),
      "Image":url
      }).then((value) {
        debugPrint('User Uploaded');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Container(
              width: 400,
              height: 600,
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
                  InkWell(
                    onTap: (){
                      showAlertBox();
                    },
                    child: pickedImage != null? CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(pickedImage! ),
                    ):CircleAvatar(
                      radius: 80,
                     child: Icon(Icons.person,size: 80,),
                    ),
                  ),

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
                    signUp(email.text.toString(),password.text.toString());
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
      ),
    );
  }

  pickImage(ImageSource imageSource) async{
    try{
      final photo  = await ImagePicker().pickImage(source: imageSource);
      if(photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    }catch(ex){
      log(ex.toString() as num);
    }
  }
}
