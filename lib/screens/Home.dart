import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './CreatePin.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;
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

    this.setState(() {
      _image = picture;
    });

    if (picture != null) {
      // send req with image to server

      // move to next screen
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CreatePinPage(
                    picture: picture,
                  )));
    }

    print(picture);
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
        Padding(
            padding: EdgeInsets.only(right: 100.0, left: 100.0, bottom: 40.0),
            child: TextField(
              controller: pinCodeController,
              decoration: InputDecoration(hintText: 'Pin Code'),
              onChanged: (text) {
                if (text.length == 6) {
                  // Send req to server with pincode
                  print("Got 6 numbers");
                }
              },
            )),
        Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2 - 30,
                left: MediaQuery.of(context).size.width / 2 - 30),
            child: new RaisedButton(
                child: Icon(Icons.camera_alt),
                onPressed: _handleCameraButton,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))))
      ]),
    );
  }
}
