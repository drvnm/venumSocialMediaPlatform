import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/services/groups.dart';

class AddChat extends StatefulWidget {
  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  GroupService _chatService = GroupService();
  String username = "";
  String groupName = "";
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          title: Text("Add person to group"),
          backgroundColor: bg,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "USERNAME",
                  labelStyle: GoogleFonts.varelaRound(
                    height: -20,
                    textStyle: TextStyle(
                      letterSpacing: 2,
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (val) => setState(() {
                  username = val;
                  print(username);
                }),
              ),
            ),
               Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "GROUP NAME",
                      labelStyle: GoogleFonts.varelaRound(
                        height: -20,
                        textStyle: TextStyle(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    onChanged: (val) => setState(() {
                      groupName = val;
                      print(groupName);
                    }),
                  ),
                ),
            ElevatedButton(
              child: Text("Create Group"),
              onPressed: () async {
                if (username != null && groupName != null) {
                  await _chatService.addGroup(username, groupName);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ));
  }
}
