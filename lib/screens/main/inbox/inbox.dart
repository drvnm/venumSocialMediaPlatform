import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    Color bg = Colors.black;
    Color fg = Color(0xff121212);
    Color tg = Color(0xff595959);
    return Scaffold(
      backgroundColor: bg,
        appBar: AppBar(
      backgroundColor: bg,
      centerTitle: true,
      title: Text("Inbox", style: GoogleFonts.montserrat()),
      actions: [
        IconButton(
          icon: Icon(Icons.message_sharp, color: Colors.white),
          onPressed: () {
            Navigator.pushNamed(context, '/messages');
          },
        ),
      ],
    ));
  }
}
