import 'package:flutter/material.dart';
import 'package:social_app/screens/authentication/login.dart';
import '../../services/auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Color bg = Colors.black;
  Color fg = Color(0xff2A2A2A);
  Color tg = Color(0xff595959);
  final AuthService _authService = AuthService();
  String email = '';
  String password = '';
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: null,
        backgroundColor: bg,
        elevation: 0,
      ),
      backgroundColor: bg,
      body: SingleChildScrollView (
        physics: ClampingScrollPhysics(),
              child: Container(
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
                        obscureText: isObscure,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          suffixIcon: isObscure
                              ? IconButton(
                                  icon: Icon(Icons.remove_red_eye_outlined,
                                      color: Colors.white),
                                  onPressed: () {
                                    isObscure = !isObscure;
                                    setState(() {});
                                  })
                              : IconButton(
                                  icon: Icon(Icons.remove_red_eye,
                                      color: Colors.white),
                                  onPressed: () {
                                    isObscure = !isObscure;
                                    setState(() {});
                                  }),
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
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color>(
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
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterPageTwo()));
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
      ),
    );
  }
}
