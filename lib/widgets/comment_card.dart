import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommentCard extends StatelessWidget {
  final postsnap;
  final usersnap;
  const CommentCard({Key? key, required this.usersnap,required this.postsnap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  postsnap.data()['profilePic'],
                ),
                radius: 18,
              ),
              Expanded(
                child: Container(
                  padding:const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  margin:const EdgeInsets.symmetric(vertical: 10,horizontal: 15),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(postsnap.data()['name'],style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(DateFormat.yMMMd().format(postsnap.data()['datePublished'].toDate())),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(postsnap.data()['text']),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60),
            child: Text('Like | Reply'),
          )
        ],
      ),
    );
  }
}
