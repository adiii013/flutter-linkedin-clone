import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/model/user.dart';
import 'package:linkedin_clone/screens/drawer_page.dart';
import 'package:linkedin_clone/utils/utils.dart';

class HomePage extends StatefulWidget {
  var userData;
  HomePage({Key? key,required this.userData}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            scaffoldKey.currentState!.openDrawer();
          },
          child: Container(
            margin: EdgeInsets.all(10),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.userData['photoUrl']),
            ),
          ),
        ),
        centerTitle: false,
        title: ListTile(
          leading: const Icon(Icons.search),
          title: TextField(
            controller: _search,
            decoration: InputDecoration(hintText: 'Search'),
          ),
          trailing: IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
        ),
      ),
      drawer: DrawerPage(
        userdata: widget.userData
      ),
    );
  }
}
