import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
// import 'dart:io';
import './CreatePin.dart';
import './ReceiptScreen.dart';
import '../classes/receipt.dart';
import '../utils/auth.dart';
import '../utils/reciept.dart';
import '../widgets/Template.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // File _image;
  final pinCodeController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    pinCodeController.dispose();
    super.dispose();
  }

  void _handleCameraButton() async {
    var picture = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (picture != null) {
      // send req with image to server - if receipt

      // move to next screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePinPage(
                    picture: picture,
                  )));
    }
  }

  void _handleSignout() {
    AuthService auth = new AuthService();
    auth.signOut();
  }

  void _handlePinCodeChanged(String text) async {
    if (text.length >= 6) {
      // Send req to server with pincode
      getReceiptFromFirebase(text).then((docsnap) {
        if (docsnap.exists) {
          // move to next screen
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptScreen(
                        pincode: text,
                      )));
        }
      }).catchError((err) {
        print(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Template(
      marginTop: 100.0,
      imageAsset: 'assets/images/logo.png',
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 100.0, left: 100.0, bottom: 40.0),
            child: Container(
                margin: EdgeInsets.only(top: 50.0),
                child: TextField(
                  controller: pinCodeController,
                  decoration: InputDecoration(hintText: 'Pin Code'),
                  onChanged: _handlePinCodeChanged,
                ))),
        Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2 - 30,
                left: MediaQuery.of(context).size.width / 2 - 30),
            child: new RaisedButton(
                child: Icon(Icons.camera_alt),
                onPressed: _handleCameraButton,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))),
        Container(
            margin: EdgeInsets.only(top: 150.0),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.5,
            ),
            width: 150.0,
            child: SignInButton(
              Buttons.Google,
              text: "Sign out",
              onPressed: this._handleSignout,
            ))
      ],
    ));
  }
}
