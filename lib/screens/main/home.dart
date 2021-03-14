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
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text("logout"),
            onPressed: () {
              AuthService().signOut();
            },
          )
        ],
        title: Text("home"),
        backgroundColor: bg,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: Icon(Icons.add_sharp),
      ),
      drawer: Drawer(
        child: ListView(
          children: [],
        ),
      ),
      body: StreamProvider.value(
          value: PostService().getPostsFromFollowingUsers(),
          child: ListPostsFeed()),
    );
  }
}
