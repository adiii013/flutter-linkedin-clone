import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String name;
  String email;
  String uid;
  List followers;
  List following;
  String photoUrl;
  UserData({
    required this.email,
    required this.name,
    required this.uid,
    required this.followers,
    required this.following,
    required this.photoUrl,
  });

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserData(
        email: snapshot['email'],
        name: snapshot['name'],
        uid: snapshot['uid'],
        followers: snapshot['followers'],
        following: snapshot['following'],
        photoUrl: snapshot['photoUrl']);
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'name': name,
        'uid': uid,
        'photoUrl': photoUrl,
        'followers': followers,
        'following': following,
      };
}
