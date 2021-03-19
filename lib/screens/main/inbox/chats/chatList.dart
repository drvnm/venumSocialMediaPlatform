import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/group.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    List<GroupModel> groups = Provider.of<List<GroupModel>>(context) ?? [];

    return ListView.builder(
        itemCount: groups.length,
        itemBuilder: (context, index) {
          GroupModel group = groups[index];
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              tileColor: fg,
              title: Text(group.groupName, style: TextStyle(color: Colors.white)),
            ),
          );
        });
  }
}
