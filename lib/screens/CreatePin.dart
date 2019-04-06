import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _handleGetPinCode() async {
    if (peopleNumController.text != "") {
      this.setState(() {
        _isSentToServer = true;
      });
      int numOfPeople = double.parse(peopleNumController.text).floor();
      String pincode = _generatePinCode();
      // Get dishes from receiptPredictor
      Firestore.instance.collection("receipts").document(pincode).setData({
        'numOfPeople': numOfPeople,
        'dishes': [
          {'amount': 3, 'name': 'מנה טעימה', 'price': 50, 'userIds': []}
        ],
        'price': 150,
        'users': []
      });
      this.setState(() {
        _isSentToServer = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ReceiptScreen(
                    pincode: pincode,
                  )));
    }
  }

  String _generatePinCode() {
    const String salt_chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    List<String> list = new List();
    Random rnd = new Random();
    for (int i = 0; i < 4; i++) {
      int index = rnd.nextInt(salt_chars.length);
      list.add(salt_chars[index]);
    }
    return list.join();
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
