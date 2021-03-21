import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/inbox/chats/messageList.dart';
import 'package:social_app/services/groups.dart';
import 'package:social_app/services/user.dart';

class ChatRoom extends StatefulWidget {
  final String groupName;
  final String groupId;

  ChatRoom({this.groupName, this.groupId});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _controllerTwo = ScrollController();
  String message = "";
  GroupService _groupService = GroupService();
  UserService _userService = UserService();
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 1,
        shadowColor: Colors.grey,
        title: Text(
          widget.groupName,
        ),
        actions: [TextButton(child: Icon(Icons.person_add_sharp, color: Colors.white))],
      ),
      body: Column(children: [
        ListMessages(controller: _controllerTwo,),
        Row(
          children: [
            Expanded(
              child: TextField(
                 textInputAction: TextInputAction.go,
                 onSubmitted: (String _) async {
                if(message!= ""){
                  await _groupService.addMessage(widget.groupId, message,
                      );
                  message = '';
                  _controller.clear();
                  _controllerTwo.jumpTo(_controllerTwo.position.maxScrollExtent);
                  return;
                }
                print("text was empty..");
               
              },
                controller: _controller,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Share your thoughts!",
                  hintStyle: TextStyle(color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15.0)),
                ),
                onChanged: (value) {
                  message = value;
                },
              ),
            ),
            TextButton(
              child: Icon(Icons.send_sharp, color: Colors.white),
              onPressed: () async {
                if(message!= ""){
                  await _groupService.addMessage(widget.groupId, message,
                      );
                  message = '';
                  _controller.clear();
                  _controllerTwo.jumpTo(_controllerTwo.position.maxScrollExtent);
                  return;
                }
                print("text was empty..");
                // } else {
                //   print(FirebaseAuth.instance.currentUser.uid);
                //   print(Provider.of<UserModel>(context, listen: false)
                //       .isVerified);
                // }
              },
            ),
          ],
        ),
      ]),
    );
  }
}

