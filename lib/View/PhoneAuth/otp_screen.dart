import 'dart:math';

import 'package:cloud_firebase_app/View/Home/view/MyHome/MyHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  String verficationid;
  OtpScreen({super.key, required this.verficationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Screen'),
      centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: otpController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            try{
              PhoneAuthCredential credential =
              PhoneAuthProvider.credential(
                  verificationId:widget.verficationid,
                  smsCode: otpController.text.toString());
              FirebaseAuth.instance.signInWithCredential(
                  credential).then((value) {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return MyHomePage();
                    }));
              });
            }catch(ex){
              log(ex.toString() as num);
            }
          }, child: Text('Verify OTP'))
        ],
      ),
    );
  }
}
