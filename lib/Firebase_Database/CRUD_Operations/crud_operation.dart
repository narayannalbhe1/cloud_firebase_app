import 'package:cloud_firebase_app/Firebase_Database/CRUD_Operations/AddPost/add_post_screen.dart';
import 'package:flutter/material.dart';

class CrudOperation extends StatefulWidget {
  const CrudOperation({super.key});

  @override
  State<CrudOperation> createState() => _CrudOperationState();
}

class _CrudOperationState extends State<CrudOperation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         leading: IconButton(
           onPressed: (){
             return Navigator.pop(context);
           },
           icon: Icon(Icons.arrow_back),
         ),
         title: Text('CRUD Operations'),
         centerTitle: true,
         backgroundColor: Colors.deepPurple,
         automaticallyImplyLeading: false,
       ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddPostScreen();
                    }));
                  }, child: Text('Add post Screen',style: TextStyle(
                  color: Colors.white),),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
