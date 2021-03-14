import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
    Color bg = Colors.black;
    Color fg = Color(0xff222222);

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Container(
            height: 80,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 30.0, right: 30.0),
              child: TextField(
                style: TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search,
                autofocus: true,
                onChanged: (val) async {
                  username = val;
                  users = await userService.getUsersFromName(username);

                  setState(() {});
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(19.0),
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Colors.grey,
                    size: 25,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Card(
                    color: fg,
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileSearch(userId: users[index].id)),
                        );
                      },
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
                                  style: GoogleFonts.montserrat(
                                      textStyle:
                                          TextStyle(color: Colors.white))),
                            ),
                            user.isVerified
                                ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 6.0, bottom: 3),
                                    child: Icon(Icons.verified_sharp,
                                        color: Colors.blue),
                                  )
                                : Text(''),
                          ],
                        ),
                      ),
                      subtitle: Text(
                        user.postAmount.toString() + " Posts",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ));
              },
            ),
          )
        ],
      ),
    );
  }
}
