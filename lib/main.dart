import 'package:chat_app/helper/Authenticattion.dart';
import 'package:chat_app/helper/helper_function.dart';
import 'package:chat_app/views/chatRooms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn;
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  getLoggedInState() async{
    await HelperFunctions.getUserLoginPref().then((value){
      userIsLoggedIn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromRGBO(173, 35, 107, .4),
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:userIsLoggedIn!=null ? userIsLoggedIn ? ChatRoomScreen(): Authenticate(): Authenticate(),
    );

  }

}

