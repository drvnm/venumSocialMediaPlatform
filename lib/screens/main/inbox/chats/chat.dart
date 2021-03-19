import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/screens/main/inbox/chats/messageList.dart';
import 'package:social_app/services/groups.dart';

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
      ),
      body: Column(
        children: [
          StreamProvider.value(
              value: _groupService.getMessagesByGroup(widget.groupId),
              child: ListMessages()),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
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
                      if (message != '') {
                        await _groupService.addMessage(widget.groupId, message);
                        message = "";
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
