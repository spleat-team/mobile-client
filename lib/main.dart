import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import './screens/Home.dart';
import './screens/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Spleat',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: _handleCurrentScreen());
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}

Widget _handleCurrentScreen() {
  return Scaffold(
      body: new StreamBuilder<FirebaseUser>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return new Center(child: new CircularProgressIndicator());
            } else {
              if (snapshot.hasData) {
                return new HomePage();
              }

              // return login
              return new LoginPage();
            }
          }));
}
