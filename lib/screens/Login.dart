import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import '../utils/auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    super.dispose();
  }

  void _handleSignIn() async {
    AuthService auth = new AuthService();
    await auth.googleSignIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
        Container(
            height: 350.0,
            width: MediaQuery.of(context).size.width,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            )))),
        SignInButton(
          Buttons.Google,
          text: "Sign up with Google",
          onPressed: this._handleSignIn,
        )
      ]),
    );
  }
}
