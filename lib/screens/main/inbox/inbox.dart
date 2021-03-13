import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Inbox extends StatefulWidget {
  @override
  _InboxState createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    Color bg = Color(0xff121212);
    Color fg = Color(0xff222222);
    return Scaffold(
        appBar: AppBar(
      backgroundColor: bg,
      centerTitle: true,
      title: Text("Inbox", style: GoogleFonts.montserrat()),
      actions: [
        IconButton(
          icon: Icon(Icons.message_sharp, color: Colors.white),
          onPressed: () {},
        ),
      ],
    ));
  }
}
