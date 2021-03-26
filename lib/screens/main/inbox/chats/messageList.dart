import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/message.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/profile/profileSearch.dart';
import 'package:bubble/bubble.dart';

Color bg = Colors.black;
Color fg = Color(0xff2A2A2A);
Color tg = Color(0xff595959);

class ListMessages extends StatefulWidget {
  ScrollController controller;
  ListMessages({this.controller});
  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  @override
  Widget build(BuildContext context) {
    List<MessageModel> messages =
        Provider.of<List<MessageModel>>(context) ?? [];
    String userId = FirebaseAuth.instance.currentUser.uid;
    print("----");
    Timer(
        Duration(milliseconds: 500),
        () => widget.controller
            .jumpTo(widget.controller.position.maxScrollExtent));
    return Expanded(
      child: ListView.builder(
          controller: widget.controller,
          itemCount: messages.length,
          itemBuilder: (context, index) {
            print(index);
            MessageModel message = messages[index];
            return message.creator == userId
                ? index != 0 && message.creator == messages[index - 1].creator
                    ? oldMessageBoxSelf(message, context)
                    : newMessageBoxSelf(message, context)
                // -------------------------------------------------------------------------------------------------
                : index != 0 && message.creator == messages[index - 1].creator
                    ? oldMessageBoxOther(message, context)
                    : newMessageBoxOther(message, context);
          }),
    );
  }
}

Widget newMessageBoxSelf(MessageModel message, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7.0),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(4),
                  ),
                  child: Bubble(
                    alignment: Alignment.topRight,
                    
                    color: Colors.blue,
                    padding: BubbleEdges.all(9.0),
                    stick: true,
                    nip: BubbleNip.no,
                    child: Text(message.text ?? "test",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget oldMessageBoxSelf(MessageModel message, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 7),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(4),
                  ),
                  child: Bubble(
                    alignment: Alignment.topRight,
                    color: Colors.blue,
                    padding: BubbleEdges.all(9.0),
                    stick: true,
                    nip: BubbleNip.no,
                    child: Text(message.text ?? "test",
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget newMessageBoxOther(message, context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        ProfileSearch(userId: message.creator)));
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ClipOval(
              child: Image.network(
                message.profileImgUrl ??
                    "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jpg",
                height: 35,
                width: 35,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(message.name ?? "NULL",
                        style: TextStyle(color: Colors.white)),
                    message.isVerified
                        ? Icon(Icons.verified_sharp,
                            color: Colors.blue, size: 15)
                        : Container(),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(0),
                    ),
                    child: Bubble(
                      margin: BubbleEdges.only(top: 3),
                      padding: BubbleEdges.all(9),
                      color: fg,
                      alignment: Alignment.topLeft,
                      stick: true,
                      nip: BubbleNip.no,
                      child: Text(
                        message.text ?? "test",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget oldMessageBoxOther(message, context) {
  return Padding(
    padding: const EdgeInsets.only(left: 50.0),
    child: Bubble(
      margin: BubbleEdges.only(top: 0),
      padding: BubbleEdges.all(9.0),
      color: fg,
      alignment: Alignment.topLeft,
      stick: true,
      nip: BubbleNip.no,
      child: Text(message.text ?? "test",
          style: TextStyle(color: Colors.white, fontSize: 15)),
    ),
  );
}
