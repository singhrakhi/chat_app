import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: Container(
        child: Column(
          children: [
            Container(color: Color(0x54ffffff),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: searchEditController,
                        decoration: InputDecoration(
                          hintText: "Search username",
                          hintStyle: TextStyle(
                            color: Colors.white60
                          ),
                          border: InputBorder.none
                        ),
                      )),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0x36ffffff),
                          Color(0x0fffffff),
                        ]
                      ),
                      borderRadius: BorderRadius.circular(42)
                    ),
                    height: 50,
                    width: 50,
                    padding: EdgeInsets.all(10),
                      child: Icon(Icons.search))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
