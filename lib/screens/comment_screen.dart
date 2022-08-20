import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/services/firestore_methods.dart';
import 'package:linkedin_clone/utils/utils.dart';
import 'package:linkedin_clone/widgets/comment_card.dart';

class CommentScreen extends StatefulWidget {
  final snap;
  final usersnap;
  CommentScreen({Key? key, required this.snap, required this.usersnap})
      : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController commentEditingController =
      TextEditingController();

  void postComment(String uid, String name, String profilePic) async {
    try {
      String res = await FireStoreMethods().postComment(
        widget.snap['postId'],
        commentEditingController.text,
        uid,
        name,
        profilePic,
      );

      if (res != 'success') {
        showSnackBar(
          res,
          context,
        );
      }
      setState(() {
        commentEditingController.text = "";
      });
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Comments'),
          centerTitle: false,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .doc(widget.snap['postId'])
              .collection('comments')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (ctx, index) {
                  return CommentCard(
                    postsnap: snapshot.data!.docs[index],
                    usersnap: widget.usersnap,
                  );
                });
          },
        ),
        bottomNavigationBar: SafeArea(
            child: Container(
                height: kToolbarHeight,
                margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                padding: const EdgeInsets.only(left: 16, right: 8),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage(widget.usersnap['photoUrl']),
                      radius: 18,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: TextField(
                          controller: commentEditingController,
                          decoration: InputDecoration(
                            hintText: 'Comment as ${widget.usersnap['name']}',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (e) {
                            postComment(
                                widget.usersnap['uid'],
                                widget.usersnap['name'],
                                widget.usersnap['photoUrl']);
                          },
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
