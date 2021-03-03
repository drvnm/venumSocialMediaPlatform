import 'package:flutter/material.dart';
import 'package:social_app/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("home"),
          actions: [
            TextButton(
              onPressed: AuthService().signOut,
              child: Icon(Icons.person),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: Icon(Icons.add_sharp),
        ));
  }
}
