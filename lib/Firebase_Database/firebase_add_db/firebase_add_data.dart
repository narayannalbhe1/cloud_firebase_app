import 'dart:developer';

import 'package:cloud_firebase_app/View/Auth/Widgets/ui_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseAddData extends StatefulWidget {
  const FirebaseAddData({super.key});

  @override
  State<FirebaseAddData> createState() => _FirebaseAddDataState();
}

class _FirebaseAddDataState extends State<FirebaseAddData> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('Add Data '),
         centerTitle: true,
       ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UiHelper.customTextField(
            controller: title,
            hintText: "Title",
            icon: Icon(Icons.title),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your title';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          UiHelper.customTextField(
            controller: description,
            hintText: "Description",
            icon: Icon(Icons.description),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your description';
              }
              return null;
            },
          ),
          SizedBox(height: 50),
          UiHelper.RoundButton((){
            addData(title.text.toString(),description.text.toString());
          },"Save Data"),

        ],
      ),
    );
  }

  addData(String title, String description){
    if(title == "" && description ==""){
      log("Enter Required fields");
    }
    else{
      FirebaseFirestore.instance.collection("User").doc(title).set({
        "Title":title,
        "Description":description
      }).then((value) {
        log("Data Inserted");
      });
    }
  }

}
