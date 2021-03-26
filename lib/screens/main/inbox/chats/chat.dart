import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/inbox/chats/chatRoom.dart';
import 'package:social_app/screens/main/inbox/chats/messageList.dart';
import 'package:social_app/services/groups.dart';
import 'package:social_app/services/user.dart';

class Chat extends StatefulWidget {
  final String groupName;
  final String groupId;

  Chat({this.groupName, this.groupId});
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String message = "";
  GroupService _groupService = GroupService();
  UserService _userService = UserService();
  var _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return MultiProvider(
        providers: [
          StreamProvider.value(
              value: _userService
                  .getUserInfo(FirebaseAuth.instance.currentUser.uid)),
          StreamProvider.value(
              value: _groupService.getMessagesByGroup(widget.groupId)),
        ],
        child: ChatRoom(
          groupId: widget.groupId,
          groupName: widget.groupName,
        ));
  }
}
