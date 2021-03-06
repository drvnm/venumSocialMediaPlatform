import 'package:flutter/material.dart';
import 'package:social_app/screens/main/profile/profile.dart';
import 'package:social_app/screens/main/profile/profileSearch.dart';
import 'package:social_app/services/user.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String username = '';
  UserService userService = UserService();
  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff1E1E1E);
    return Scaffold(
      backgroundColor: bg,
      body: Center(
        child: Column(children: [
          Icon(Icons.arrow_back_sharp),
          TextFormField(
            onChanged: (val) {
              username = val;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search_sharp, color: Colors.white),
            ),
          ),
          TextButton(
              onPressed: () async {
                String result = await userService.getIdByUsername(username);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileSearch(
                            userId: result,
                          )),
                );
              },
              child: Text("Search"))
        ]),
      ),
    );
  }
}
