import 'package:flutter/material.dart';
import 'package:social_app/models/user.dart';

import 'package:social_app/screens/main/profile/profile.dart';
import 'package:social_app/screens/main/profile/profileSearch.dart';
import 'package:social_app/services/user.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String username = '';
  List<UserModel> users = [];
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff1E1E1E);
    Color fg = Color(0xff222222);
    ;
    return Scaffold(
      backgroundColor: fg,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Row(children: [
              Flexible(
                child: TextFormField(
                  onChanged: (val) {
                    username = val;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search_sharp, color: Colors.white),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    users = await userService.getUsersFromName(username);

                    setState(() {});
                  },
                  child: Text("Search")),
            ]),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Card(
                  color: bg,
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImgUrl),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 0.0, bottom: 0),
                            child: Text(user.name ?? 'LOADING',
                                style: TextStyle(color: Colors.white)),
                          ),
                          user.isVerified
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 6.0, bottom: 3),
                                  child:
                                      Icon(Icons.verified_sharp, color: Colors.blue),
                                )
                              : Text(''),
                        ],
                      ),
                    ),
                    subtitle: Text(user.postAmount.toString() + " Posts"),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
