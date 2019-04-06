import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:flutter/foundation.dart';
import '../classes/receipt.dart';
import 'package:share/share.dart';
import '../widgets/DishesList.dart';
import '../utils/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/ReceiptBody.dart';

class ReceiptScreen extends StatefulWidget {
  ReceiptScreen({Key key, @required this.pincode}) : super(key: key);

  final String pincode;

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
    String str = "Spleat pin code: " + widget.pincode;
    Share.share(str);
  }

  void _handleFinishMarking() async {
    AuthService auth = AuthService();
    FirebaseUser user = await auth.getCurrentUser();
    String userEmail = user.email;
    // Update user dishes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pin Code: " + widget.pincode),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: _handlePinCodeShareToWhatsUp,
          )
        ],
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('receipts')
            .document(widget.pincode)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...');
            default:
              final Receipt rec = Receipt.buildReceiptFromJson(
                  widget.pincode, snapshot.data.data);
              return ReceiptBody(receipt: rec);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: this._handleFinishMarking,
      ),
    );
  }
}
