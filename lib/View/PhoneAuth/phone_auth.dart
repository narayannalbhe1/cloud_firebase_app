import 'package:cloud_firebase_app/View/PhoneAuth/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Auth'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: phoneController,
          ),
          Container(
            width: 200,
            height: 40,
            color: Colors.deepPurple,
            child: ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.verifyPhoneNumber(
                      verificationCompleted:
                          (PhoneAuthCredential credential) {},
                      verificationFailed: (FirebaseAuthException ex) {},
                      codeSent: (String verificationid, int? resendtoken) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return OtpScreen(verficationid: verificationid,);
                        }));
                      },
                      codeAutoRetrievalTimeout: (String verificationId) {},
                  phoneNumber: phoneController.text.toString());
                },
                child: Text(
                  'Verify Phone Number',
                  style: TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
