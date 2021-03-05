import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main/home.dart';
import 'main/profile/profile.dart';
import 'package:social_app/screens/main/search/search.dart';

class PageCon extends StatefulWidget {
  @override
  _PageControllerState createState() => _PageControllerState();
}

class _PageControllerState extends State<PageCon> {
  Color background = Color(0xff252525);
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
        unselectedLabelStyle: GoogleFonts.montserrat(),
        selectedLabelStyle: GoogleFonts.montserrat(),
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
