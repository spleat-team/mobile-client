import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:core';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:spleat/classes/receipt.dart';
import './ReceiptScreen.dart';
import '../utils/reciept.dart';

class CreatePinPage extends StatefulWidget {
  CreatePinPage({Key key, @required this.picture}) : super(key: key);
  final File picture;
  @override
  _CreatePinPageState createState() => _CreatePinPageState();
}

class _CreatePinPageState extends State<CreatePinPage> {
  final peopleNumController = TextEditingController();
  bool _isSentToServer = false;

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    peopleNumController.dispose();
    super.dispose();
  }

  static String _encodePicture(List<int> imageBytes) {
    return base64Encode(imageBytes);
  }

  void _handleGetPinCode() async {
    if (peopleNumController.text != "") {
      this.setState(() {
        _isSentToServer = true;
      });
      int numOfPeople = double.parse(peopleNumController.text).floor();
      //List<int> imageBytes = await widget.picture.readAsBytes();
      // String base64Image = await compute(_encodePicture, imageBytes);
      String base64Image = "";
      // send number of people and get pin code
      Receipt r = await sendReceipt(base64Image, numOfPeople);
      this.setState(() {
        _isSentToServer = false;
      });
      if (r != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceiptScreen(
                      receipt: r,
                    )));
      } else {
        print("problem with sending receipt");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          ListView(physics: NeverScrollableScrollPhysics(), children: <Widget>[
        Padding(
            padding: this._isSentToServer
                ? EdgeInsets.only(top: 0.0)
                : EdgeInsets.only(top: 0),
            child: this._isSentToServer
                ? const Center(child: CircularProgressIndicator())
                : Container()),
        Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2 - 70,
                left: MediaQuery.of(context).size.width / 2 - 70),
            child: new RaisedButton(
                child: Text("Back"),
                onPressed: () => Navigator.pop(context),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)))),
        Container(
            height: 300.0,
            width: MediaQuery.of(context).size.width,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            )))),
        Padding(
            padding: EdgeInsets.only(right: 100.0, left: 100.0, bottom: 40.0),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(),
              controller: peopleNumController,
              decoration: InputDecoration(hintText: 'How many people?'),
            )),
        Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2 - 70,
                left: MediaQuery.of(context).size.width / 2 - 70),
            child: new RaisedButton(
                child: Text("Get pin code"),
                onPressed: _handleGetPinCode,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))))
      ]),
    );
  }
}
