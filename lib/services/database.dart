import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUserName(String userName){

  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
        .add(userMap);
  }
}