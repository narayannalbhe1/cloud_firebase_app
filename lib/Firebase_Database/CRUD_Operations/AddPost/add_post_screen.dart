import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref("Test"); // firebase reference create example table name: Post

  final postcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: postcontroller,
              decoration: InputDecoration(
                hintText: "What is in your mind?",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: (){
                  // addPostData(postcontroller.text.toString(),);
                  setState(() {
                    loading = true;
                  });

                  databaseRef.child("desc").set({
                    "Description" : postcontroller.text.toString(),
                  }).then((value) {
                    Fluttertoast.showToast(msg: "Post added");
                    setState(() {
                      loading = true;
                    });
                  }).onError((error, stackTrace){
                    Fluttertoast.showToast(msg: error.toString());
                    setState(() {
                      loading = true;
                    });
                  });
                }, child: Text('Add')),
          ],
        ),
      ),

    );
  }

  addPostData(String post){
    if(post == ""){
      log("Enter Required fields");
    }
    else{
      FirebaseFirestore.instance.collection("Post").doc(post).set({
        "Post":post,
      }).then((value) {
        log("Data Inserted");
      });
    }
  }

}
