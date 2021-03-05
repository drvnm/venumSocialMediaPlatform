import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/services/posts.dart';
import 'package:google_fonts/google_fonts.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  Color bg = Color(0xff313131);
  final PostService _postService = PostService();
  String text = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bg,
        appBar: AppBar(
          backgroundColor: bg,
          elevation: 1,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () async {
                  if (text != '') {
                    _postService.savePost(text, FirebaseAuth.instance.currentUser.uid);
                    Navigator.pop(context);
                  }
                },
                child: Text("Post", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Form(
                child: TextFormField(
              style: TextStyle(color: Colors.white),
              maxLines: null,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    bottom: 80.0,
                  ),
                  hintText: "Share your thougts.",
                  hintStyle: TextStyle(color: Colors.white)),
              maxLength: 180,
              autofocus: true,
              cursorColor: Colors.white,
              onChanged: (val) {
                setState(() {
                  text = val;
                });
              },
            ))));
  }
}
