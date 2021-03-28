import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/post.dart';
import 'package:social_app/screens/main/posts/feedList.dart';
import 'package:social_app/screens/main/posts/list.dart';
import 'package:social_app/services/auth.dart';
import 'package:social_app/services/posts.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
   
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        actions: [
          TextButton(
            child: Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
        centerTitle: true,
        title: Text("HOME"),
        backgroundColor: bg,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add_sharp),
      ),
      body: StreamProvider.value(
        value: PostService().getFeedFromFollowing(),
        child: Center(
          child: Text("USER FEED WILL BE HERE.",
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
