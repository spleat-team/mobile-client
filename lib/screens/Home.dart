import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import './CreatePin.dart';
import './ReceiptScreen.dart';
import 'package:http/http.dart' as http;
import '../classes/receipt.dart';
import '../classes/dish.dart';

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

  void _handlePinCodeChanged(String text) async {
    if (text.length >= 6) {
      // Send req to server with pincode
      http.get('http://10.100.102.22:8000/receipts/' + text).then((response) {
        dynamic c = JsonDecoder().convert(response.body);
        List<Dish> dishes = Receipt.buildFromJson(c["dishes"]);
        Receipt r = Receipt(dishes, c["pincode"], c["numOfPeople"],
            double.parse(c["price"].toString()));
        // move to next screen
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceiptScreen(
                      receipt: r,
                    )));
      }).catchError((err) => {print("receipt not found")});
    }
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
              onChanged: _handlePinCodeChanged,
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
