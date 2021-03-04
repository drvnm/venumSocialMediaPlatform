import 'package:flutter/material.dart';
import 'main/home.dart';
import 'main/profile/profile.dart';

// import 'package:social_app/models/user.dart';
// import 'package:social_app/screens/authentication/signup.dart';
// import 'package:social_app/screens/main/posts/add.dart';


class PageCon extends StatefulWidget {
  @override
  _PageControllerState createState() => _PageControllerState();
}

class _PageControllerState extends State<PageCon> {
  Color background = Color(0xff181818);
  int _currentIndex = 0;
  var pages = [Home(), Home(), Home(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: <BottomNavigationBarItem>[
          item("Home", Icons.home_sharp),
          item("Search", Icons.search_sharp),
          
          item("Inbox", Icons.message_sharp),
          item("Profile", Icons.person_sharp),
        ],
        backgroundColor: background,
      ),
    );
  }
}

BottomNavigationBarItem item(String label, IconData icon) {
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: label,
    backgroundColor: Colors.white,
  );
}