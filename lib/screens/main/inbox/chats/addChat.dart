import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/services/groups.dart';
import 'package:image_picker/image_picker.dart';

class AddChat extends StatefulWidget {
  @override
  _AddChatState createState() => _AddChatState();
}

class _AddChatState extends State<AddChat> {
  GroupService _chatService = GroupService();
  String username = "";
  String groupName = "";
  bool hasSelected = false;
  final picker = ImagePicker();
  File _groupImage;
  TextStyle myTextStyle = GoogleFonts.varelaRound(
    height: -20,
    textStyle: TextStyle(
      letterSpacing: 2,
      fontSize: 15,
      color: Colors.grey,
    ),
  );
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _groupImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          title: Text(
            "Add person to group",
          ),
          backgroundColor: bg,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Group picture",
              style: GoogleFonts.varelaRound(
                textStyle: TextStyle(
                  letterSpacing: 2,
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            hasSelected
                ? Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ClipOval(
                      child: Image.file(
                        _groupImage,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                )
                : IconButton(
                    icon: Icon(Icons.person_sharp, color: Colors.white),
                    onPressed: () async {
                      await getImage();
                      hasSelected = true;
                      setState(() {});
                    },
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: TextFormField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "USERNAME",
                  labelStyle: myTextStyle,
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
                  labelStyle: myTextStyle,
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
                if (username != null &&
                    groupName != null &&
                    _groupImage != null) {
                  await _chatService.addGroup(username, groupName, _groupImage);
                  Navigator.pop(context);
                } else {
                  print("The right items werent selected.");
                  return;
                }
              },
            ),
          ],
        ));
  }
}
