import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linkedin_clone/screens/login_screen.dart';
import 'package:linkedin_clone/utils/utils.dart';

class DrawerPage extends StatefulWidget {
  final userdata;
  
  DrawerPage({Key? key, required this.userdata}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  Uint8List? _file;
  bool isFile = false;

  selectImage() async {
    Uint8List im = await pickimage(ImageSource.gallery);
    setState(() {
      _file = im;
      isFile = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                     backgroundImage:
                          NetworkImage(widget.userdata['photoUrl']),
                          
                          ),
                  accountName: Text(widget.userdata['name']),
                  accountEmail: Text(widget.userdata['email'])),
              Positioned(
                bottom: 70,
                left: 60,
                child: IconButton(
                  onPressed: selectImage,
                  icon: const Icon(Icons.add_a_photo),
                ),
              )
            ]),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Text('Logout'))
          ],
        ),
      ),
    );
  }
}
