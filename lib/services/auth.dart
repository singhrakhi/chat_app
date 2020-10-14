import 'package:chat_app/model/users.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _getUserFromFirebase(User user){
    return user !=null ? Users(userId: user.uid) : null;
  }
  Future signInWithEmail(String email, String password) async{
    try{
      User user = (await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
      print(user);
      _getUserFromFirebase(user);
    } catch (e){
      print(e);
    }
  }

  Future signUpEmailAndPassword(String email, String password) async{
    try{
      User user  = (await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;
      _getUserFromFirebase(user);
    } catch(e){
      print(e);
    }
  }

  Future resetPass(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    } catch(e){
      print(e);
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e);
    }
  }

}

