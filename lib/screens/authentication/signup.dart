
import 'package:flutter/material.dart';
import '../../services/auth.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) => setState(() {
                    email = val;
                    print(email);
                  }),
                ),
                TextFormField(
                  onChanged: (val) => setState(() {
                    password = val;
                  }),
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthService().signUp(email, password);
                  },
                  child: Text("Sign Up"),
                ),
                ElevatedButton(
                  onPressed: () {
                    AuthService().signIn(email, password);
                  },
                  child: Text("Sign In"),
                )
              ],
            ),
          )),
    );
  }
}
