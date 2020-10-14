import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'chatRooms.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController passTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  AuthMethods _authMethods = new AuthMethods();
  QuerySnapshot _snapshotUserInfo;
  signIn() async{
    if(formKey.currentState.validate()){

      HelperFunctions.saveUserPref(HelperFunctions.sharedPrefUserEmailKey,emailTextEditingController.text);
      print(_databaseMethods
          .getUserByEmail(emailTextEditingController.text));

      // _databaseMethods
      //     .getUserByEmail(emailTextEditingController.text).then((value) {
      //   print(value.toString());
      //   _snapshotUserInfo= value;
      //   HelperFunctions.saveUserPref(HelperFunctions.sharedPrefUserEmailKey,_snapshotUserInfo.docs[0].get("name"));

      // });

      setState(() {
        isLoading = true;
      });

      _authMethods.signInWithEmail(emailTextEditingController.text, passTextEditingController.text)
          .then((value){
        if(value!=null){
          HelperFunctions.saveUserLoginPref(true);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatRoomScreen()),
          );
        } else{
          print("Email validation failed.");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (val){
                    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(val)? null : "Please provide valid email id ";
                  },
                  controller: emailTextEditingController,
                  style: simpleStyle(),
                  decoration: textFieldInputDecoration("Email"),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val){
                    return val.isEmpty || val.length<6 ? "Please provide password 6 character." : null;
                  },
                  controller: passTextEditingController,
                  style: simpleStyle(),
                  decoration: textFieldInputDecoration("Password"),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password?",
                      style: mediumStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: (){
                    signIn();
                  },
                  child:
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Color(0xffFE8A37),
                          Color(0xffFD7A26),
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      "Sign In",
                      style: simpleButtonStyle(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Color(0xffffffff),
                        Color(0xffffffff),
                      ]),
                      borderRadius: BorderRadius.circular(30)),
                  child: Text(
                    "Sign In with Google",
                    style: simpleButtonStyleOrange(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?  ",
                      style: mediumStyle(),
                    ),
                    GestureDetector(
                      onTap: (){
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 17),
                        child: Text(
                          "Register Now",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


