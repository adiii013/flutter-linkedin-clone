import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/screens/login_screen.dart';

class DrawerPage extends StatefulWidget {
  final userdata;
  DrawerPage({Key? key,required this.userdata}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
             UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        widget.userdata['photoUrl'])),
                accountName: Text(widget.userdata['name']),
                accountEmail: Text(widget.userdata['email'])),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseAuth.instance.signOut();
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
