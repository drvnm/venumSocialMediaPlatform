import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/screens/wrapper.dart';
import 'package:social_app/services/auth.dart';
import 'screens/authentication/login.dart';
import 'screens/authentication/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<UserModel>.value(
              value: AuthService().user,
              child: MaterialApp(
                home: Wrapper(),
              ));
        }

        return Container();
      },
    );
  }
}
