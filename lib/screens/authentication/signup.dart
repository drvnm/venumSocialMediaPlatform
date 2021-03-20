import 'package:flutter/material.dart';
import '../../services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color bg = Color(0xff181818);
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: null,
        backgroundColor: bg,
        elevation: 0,
      ),
      backgroundColor: bg,
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello,\nWelcome back.",
                  style: GoogleFonts.varelaRound(
                    textStyle: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 80.0),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: "EMAIL",
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
                      email = val;
                      print(email);
                    }),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 39.0),
                    child: TextFormField(
                      obscureText: true,
                      
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.remove_red_eye_sharp, color: Colors.white),
                        labelText: "PASSWORD",
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
                        password = val;
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Center(
                    child: Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return Color(
                                  0xff5D9DFF); // Use the component's default.
                            },
                          ),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return Color(
                                  0xff5D9DFF); // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          AuthService().signIn(email, password);
                        },
                        child: Text(
                          "SIGN IN",
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1),
                  child: Center(
                    child: Container(
                      width: 300,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed))
                                return Colors.green;
                              return bg; // Use the component's default.
                            },
                          ),
                        ),
                        onPressed: () {
                          AuthService().signUp(email, password);
                        },
                        child: Text(
                          "CREATE ACCOUNT",
                          style: GoogleFonts.varelaRound(
                            textStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
