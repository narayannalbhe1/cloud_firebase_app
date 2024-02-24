import 'package:flutter/material.dart';

class FirebaseDB extends StatefulWidget {
  const FirebaseDB({super.key});

  @override
  State<FirebaseDB> createState() => _FirebaseDBState();
}

class _FirebaseDBState extends State<FirebaseDB> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Database'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Firebase Database'),
          ],
        ),
      ),
    );
  }
}
