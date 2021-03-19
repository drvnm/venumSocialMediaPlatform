import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:social_app/screens/main/inbox/chats/chatList.dart';
import 'package:social_app/services/groups.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  GroupService _groupService = GroupService();
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        centerTitle: true,
        title: Text("Groups", style: GoogleFonts.montserrat()),
        actions: [
          IconButton(
            icon: Icon(Icons.add_sharp, color: Colors.white),
            onPressed: () {
              Navigator.pushNamed(context, "/addChat");
            },
          ),
        ],
      ),
      body: StreamProvider.value(
          value: _groupService.getGroupsFromId(), child: ChatList()),
    );
  }
}
