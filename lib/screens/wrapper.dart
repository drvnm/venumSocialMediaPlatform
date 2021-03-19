import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/authentication/signup.dart';
import 'package:social_app/screens/main/inbox/chats/chats.dart';
import 'package:social_app/screens/main/posts/add.dart';
import 'package:social_app/screens/main/profile/edit.dart';
import 'package:social_app/screens/main/search/search.dart';
import 'main/inbox/chats/addChat.dart';
import 'main/profile/profile.dart';
import 'pageController.dart'; 

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    if (user == null) {
      return RegisterPage();
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/' : (context) => PageCon(),
        '/add' : (context) => Add(),
        '/profile': (context) => Profile(),
        '/edit' : (context) => Edit(),
        '/search': (context) => Search(),
        '/messages': (context) => Chats(),
        '/addChat': (context) => AddChat(),
      }
    );

  }
}
