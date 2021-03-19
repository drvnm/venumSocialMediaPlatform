import 'package:flutter/material.dart';
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
        appBar: AppBar(
          title: Text("Add person to group"),
          backgroundColor: bg,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              onChanged: (value) {
                username = value;
                print(username);
              },
            ),
             TextFormField(
              onChanged: (value) {
                groupName = value;
                print(groupName);
              },
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
