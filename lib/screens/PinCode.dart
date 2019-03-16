import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:core';
import 'package:share/share.dart';

class PinCodePage extends StatefulWidget {
  PinCodePage({Key key, @required this.pincode}) : super(key: key);
  final String pincode;
  @override
  _PinCodePageState createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    super.dispose();
  }

  void _handlePinCodeShareToWhatsUp() async {
    String str = "Spleat pin code: " + widget.pincode;
    print(str);
    Share.share(str);
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
            child: Text(widget.pincode)),
        Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width / 2 - 70,
                left: MediaQuery.of(context).size.width / 2 - 70),
            child: new RaisedButton(
                child: Text("Share to whatsup"),
                onPressed: _handlePinCodeShareToWhatsUp,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0))))
      ]),
    );
  }
}
