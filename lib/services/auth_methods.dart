import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkedin_clone/model/user.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<UserData> getUserDetails() async {
    DocumentSnapshot documentSnapshot =
        await _firebaseFirestore.collection('users').doc(_auth.currentUser!.uid).get();
    return UserData.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser(String email, String name, String password) async {
    String res = "Some error occured";

    try {
      UserCredential _user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserData _userData = UserData(
          photoUrl: "https://t4.ftcdn.net/jpg/00/84/67/19/360_F_84671939_jxymoYZO8Oeacc3JRBDE8bSXBWj0ZfA9.jpg",email: email, name: name, uid: _user.user!.uid, followers: [],following: []);
      _firebaseFirestore
          .collection('users')
          .doc(_user.user!.uid)
          .set(_userData.toJson());
      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> signInUser(String email, String password) async {
    String res = "Some error occured";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = "success";
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
