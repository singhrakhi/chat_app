import 'package:chat_app/views/signIn.dart';
import 'package:chat_app/views/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleVIew(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(showSignIn){
      return SignIn(toggleVIew);
    } else
      return SignUp(toggleVIew);
  }
}
