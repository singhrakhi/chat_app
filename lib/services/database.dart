import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods{
  getUserByUserName(String userName) async{
    return await FirebaseFirestore.instance.collection("users")
        .where("name", isEqualTo: userName)
        .get();
  }

  uploadUserInfo(userMap){
    FirebaseFirestore.instance.collection("users")
        .add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap){
    FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId).set(chatRoomMap);
  }

}