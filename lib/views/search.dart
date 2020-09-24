import 'package:chat_app/services/database.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchEditController = new TextEditingController();
  DatabaseMethods _databaseMethods = new DatabaseMethods();
  QuerySnapshot searchSnapShot;
  initiateSearch() {
    _databaseMethods
        .getUserByUserName(searchEditController.text).then((value) {
      print(value.toString());
      setState(() {
        searchSnapShot = value;
      });
    });
  }
  // create chat room and start conversation
  createChatRoomAndStartConver(){

  }

  Widget searchList(){
    return searchSnapShot !=null ? ListView.builder(
      itemCount:searchSnapShot.docs.length,
        shrinkWrap: true,
        itemBuilder: (context,index){
        return SearchTile(
          userEmail: searchSnapShot.docs[index].get("email"),
          userName: searchSnapShot.docs[index].get("name"),
        );
    }): Container();
  }

  @override
  void initState() {
    initiateSearch();
    super.initState();
  }

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
                  GestureDetector(
                    onTap: () {

                      initiateSearch();

                      },
                    child: Container(
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
                        child: Icon(Icons.search)),
                  )
                ],
              ),
            ),
            searchList()
          ],
        ),
      ),
    );
  }
}



class SearchTile extends StatelessWidget {
  final String userName;
  final String userEmail;

  SearchTile({this.userName, this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal:20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: mediumStyle() ,
              ),
              Text(userEmail, style: mediumStyle(),)
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: (){

            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffFE8A37),
                borderRadius: BorderRadius.circular(20)
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text("Message",style: mediumStyle(),),
            ),
          )
        ],
      ),
    );
  }
}

