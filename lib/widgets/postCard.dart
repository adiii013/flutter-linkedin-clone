import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/services/auth_methods.dart';
import 'package:linkedin_clone/services/firestore_methods.dart';
import 'package:linkedin_clone/services/storage_methods.dart';
import 'package:linkedin_clone/utils/utils.dart';
import 'package:linkedin_clone/widgets/buttons.dart';

class PostCard extends StatefulWidget {
  var snap;
  PostCard({Key? key, required this.snap}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int? _likes;
  bool isFollow = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchlength();
    follow();
  }

  fetchlength() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    }
    setState(() {});
  }

  void follow() async {
    isFollow = await FireStoreMethods()
        .isFollow(FirebaseAuth.instance.currentUser!.uid, widget.snap['uid']);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(widget.snap['profImage']),
          ),
          title: Text(widget.snap['name']),
          subtitle: Text(widget.snap['name']),
          trailing:
              (widget.snap['uid'] == FirebaseAuth.instance.currentUser!.uid)
                  ? TextButton(
                      onPressed: () {},
                      child: Text(
                        '...',
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ))
                  : (isFollow)
                      ? TextButton(
                          onPressed: () async {
                            setState(() {
                              isFollow = false;
                            });
                            await FireStoreMethods().followUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                widget.snap['uid']);
                                 
                          },
                          child: Text('Following',style: TextStyle(color: Colors.black),))
                      : TextButton(
                          child: Text('+ Follow'),
                          onPressed: () async {
                            setState(() {
                              isFollow = true;
                            });
                            await FireStoreMethods().followUser(
                              FirebaseAuth.instance.currentUser!.uid,
                              widget.snap['uid'],
                            );
                            
                          },
                        ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Text(widget.snap['description']),
        ),
        (widget.snap['postUrl']=="none") ? SizedBox() :Container(
          height: 300,
          child: Image.network(
            widget.snap['postUrl'],
            fit: BoxFit.contain,
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Liked by ${widget.snap['likes'].length} people",
              style: TextStyle(color: Colors.grey[800]),
            )),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () async {
                String res = await FireStoreMethods().likePost(
                    widget.snap['postId'],
                    FirebaseAuth.instance.currentUser!.uid,
                    widget.snap['likes']);
              },
              child: ButtonLogo(
                icon: Icon(
                  Icons.thumb_up_outlined,
                  color: widget.snap['likes']
                          .contains(FirebaseAuth.instance.currentUser!.uid)
                      ? Colors.blueAccent
                      : Colors.black,
                ),
                text: 'Like',
              ),
            ),
            ButtonLogo(icon: Icon(Icons.comment), text: 'Comment'),
            ButtonLogo(icon: Icon(Icons.share), text: 'Share'),
            ButtonLogo(icon: Icon(Icons.send), text: 'Send'),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: 10,
          decoration: BoxDecoration(
            color: Colors.grey[200]
          ),
        )
      ],
    );
  }
}
