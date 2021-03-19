import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/message.dart';

class ListMessages extends StatefulWidget {
  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    List<MessageModel> messages =
        Provider.of<List<MessageModel>>(context) ?? [];
    String userId = FirebaseAuth.instance.currentUser.uid;
    return Expanded(
      child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) {
            MessageModel message = messages[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: ListTile(
                tileColor:
                    message.creator == FirebaseAuth.instance.currentUser.uid
                        ? Colors.blue
                        : fg,
                title: Text(
                  message.text ?? "test",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
