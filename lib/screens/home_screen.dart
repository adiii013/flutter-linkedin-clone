import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkedin_clone/screens/add_post_page.dart';
import 'package:linkedin_clone/screens/home_page.dart';
import 'package:linkedin_clone/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _page = 0;
  late PageController _pageController;
  bool isLoading = false;
  var userdata = {};

  @override
  void initState() {
    super.initState();
    getData();
    _pageController = PageController();
  }

  void getData() async {
    setState(() {
      isLoading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      userdata = userSnap.data() as Map<String, dynamic>;
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:(isLoading) ? const Center(child: CircularProgressIndicator(),) : PageView(
        children: [
          HomePage(userData: userdata,),
          Text('Add'),
          AddPost(userdata: userdata,),
          Text('notification'),
          Text('Jobs'),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: (_page == 0) ? Colors.black : Colors.grey,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_add,
                color: (_page == 1) ? Colors.black : Colors.grey,
              ),
              label: 'My Network'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                color: (_page == 2) ? Colors.black : Colors.grey,
              ),
              label: 'Post'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.notifications,
                color: (_page == 3) ? Colors.black : Colors.grey,
              ),
              label: 'Notifications'),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
              color: (_page == 4) ? Colors.black : Colors.grey,
            ),
            label: 'Jobs',
          ),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}
