import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/services/user.dart';

class Edit extends StatefulWidget {
  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  UserService _userService = UserService();
  String username = '';
  String bio = '';
  File _profileImage;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff222222);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        centerTitle: true,
        title: Text("Edit Profile",
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white))),
        actions: [
          TextButton(
              onPressed: () async {
                await _userService.updateProfile(_profileImage, username, bio);
                Navigator.pop(context);
              },
              child: Text("SAVE",
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.white, fontSize: 15))))
        ],
      ),
      body: Container(
        color: fg,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(30)),
                color: bg,
              ),
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: TextButton(
                onPressed: getImage,
                child: _profileImage == null
                    ? Icon(Icons.person)
                    : ClipOval(
                        child: Image.file(
                          _profileImage,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
            ),
            Expanded(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  color: fg,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: TextFormField(
                        style: TextStyle(color: Colors.white),
                        maxLength: 10,
                        decoration: InputDecoration(
                          labelText: "USERNAME",
                          labelStyle: GoogleFonts.varelaRound(
                            height: -20,
                            textStyle: TextStyle(
                              letterSpacing: 2,
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onChanged: (val) => setState(() {
                          username = val;
                          print(username);
                        }),
                      ),
                    ),
                    TextFormField(
                      maxLength: 90,
                      maxLines: null,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: "BIO",
                        labelStyle: GoogleFonts.varelaRound(
                          height: -20,
                          textStyle: TextStyle(
                            letterSpacing: 2,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onChanged: (val) => setState(() {
                        bio = val;
                      }),
                    ),
                  ])),
            )
          ],
        ),
      ),
    );
  }
}
