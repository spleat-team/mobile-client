import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/foundation.dart';
import '../classes/receipt.dart';
import 'package:share/share.dart';
import '../widgets/DishesList.dart';

class ReceiptScreen extends StatefulWidget {
  ReceiptScreen({Key key, @required this.receipt}) : super(key: key);

  final Receipt receipt;

  @override
  _ReceiptScreenState createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    super.dispose();
  }

  void _handlePinCodeShareToWhatsUp() async {
    String str = "Spleat pin code: " + widget.receipt.pincode;
    Share.share(str);
  }

  @override
  Widget build(BuildContext context) {
    Receipt rec = widget.receipt;
    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Code: " + rec.pincode),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _handlePinCodeShareToWhatsUp,
          )
        ],
      ),
      body: DishesList(rec.dishes),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () {},
      ),
    );
  }
}
