import 'package:flutter/material.dart';
import '../helpers/helper.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff313131),
      body: Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 120.0,
              ),
              child: Text(
                "Hello,\nWelcome Back.",
                style: GoogleFonts.varelaRound(
                  textStyle: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    maxLength: 9,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      labelText: "USERNAME",
                      labelStyle: GoogleFonts.varelaRound(
                        height: -20,
                        textStyle: TextStyle(
                          letterSpacing: 2,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )),
            Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.remove_red_eye),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      labelText: "PASSWORD",
                      labelStyle: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                          fontSize: 15,
                          height: -20,
                          letterSpacing: 2,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                )),
            Align(
              alignment: FractionalOffset.topRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Padding(
                  padding: const EdgeInsets.only(right: 13.0, top: 30.0),
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.varelaRound(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                  child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shadowColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green;
                        return Color(
                            0xff5D9DFF); // Use the component's default.
                      },
                    ),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.green;
                        return Color(
                            0xff5D9DFF); // Use the component's default.
                      },
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      "LOGIN",
                      style: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Center(
                  child: SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed))
                          return Color(0xff313131);
                        return Color(
                            0xff313131); // Use the component's default.
                      },
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                    child: Text(
                      "Create Account",
                      style: GoogleFonts.varelaRound(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {},
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
