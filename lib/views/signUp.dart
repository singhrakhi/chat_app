import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/chatRooms.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function toggle;
  SignUp(this.toggle);
  @override
  _SignUpState createState() =>
      _SignUpState();
}

class _SignUpState extends State<SignUp> {

  bool isLoading = false;
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  AuthMethods authMethods= new AuthMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passTextEditingController = new TextEditingController();
  TextEditingController userNameTextEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      appBar: appBarMain(context),
      body: isLoading ? Container(
        child: Center(
            child: CircularProgressIndicator()),
      ): SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
             Form(
               key: formKey,
               child: Column(
                 children: [
                   TextFormField(
                     validator: (val){
                       return val.isEmpty || val.length<2 ? "Please provide username minimum 2 character." : null;
                     },
                     controller: userNameTextEditingController,
                     style: simpleStyle(),
                     decoration: textFieldInputDecoration("Username"),
                   ),
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
                 ],
               ),
             ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: (){
                  signMe();
                },
                child: Container(
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
                    "Sign Up",
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
                  "Sign Up with Google",
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
                    "Already an account?  ",
                    style: mediumStyle(),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.toggle();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 17),
                      child: Text(
                        "Login Now",
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
    );
  }

  void signMe() {
      if(formKey.currentState.validate()){
        Map<String,String> userMap = {
          "name": userNameTextEditingController.text,
          "email": emailTextEditingController.text
        };
        setState(() {
          isLoading = true;
        });
        //
        Firebase.initializeApp();
        authMethods.signUpEmailAndPassword(emailTextEditingController.text,
            passTextEditingController.text).then((value){
            _databaseMethods.uploadUserInfo(userMap);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ChatRoomScreen()),
          );

        });
      }
  }
}
