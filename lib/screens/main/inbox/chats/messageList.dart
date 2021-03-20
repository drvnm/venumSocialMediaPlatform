import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/message.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/main/profile/profileSearch.dart';

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
            return message.creator == userId
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ListTile(
                                  tileColor: Colors.blue,
                                  title: Text(
                                    message.text ?? "test",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(message.name ?? "NULL",
                                      style: TextStyle(color: Colors.white)),
                                  message.isVerified
                                      ? Icon(Icons.verified_sharp,
                                          color: Colors.blue, size: 15)
                                      : null,
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ClipOval(
                            child: Image.network(
                              message.profileImgUrl ??
                                  "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jpg",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        ProfileSearch(
                                            userId: message.creator)));
                          },
                          child: ClipOval(
                            child: Image.network(
                              message.profileImgUrl ??
                                  "https://inlandfutures.org/wp-content/uploads/2019/12/thumbpreview-grey-avatar-designer.jpg",
                              height: 40,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: ListTile(
                                  tileColor: fg,
                                  title: Text(
                                    message.text ?? "test",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Text(message.name ?? "NULL",
                                      style: TextStyle(color: Colors.white)),
                                  message.isVerified
                                      ? Icon(Icons.verified_sharp,
                                          color: Colors.blue, size: 15)
                                      : null,
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
