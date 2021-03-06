import 'package:flutter/material.dart';
import 'package:social_app/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff1E1E1E);
    return Scaffold(
        appBar: AppBar(
          title: Text("home"),
          backgroundColor: bg,
          actions: [
            TextButton(
              onPressed: AuthService().signOut,
              child: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: Icon(Icons.add_sharp),
        ),
        drawer: Drawer(
          child: ListView(children: [
            
          ],),
        ));
  }
}
