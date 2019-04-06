import 'package:flutter/material.dart';
import 'package:spleat/classes/receipt.dart';
import './DishesList.dart';
import './UsersList.dart';

class ReceiptBody extends StatelessWidget {
  final Receipt receipt;

  ReceiptBody({@required this.receipt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(flex: 1, child: UsersList(users: this.receipt.users)),
        Expanded(flex: 6, child: DishesList(this.receipt.dishes))
      ],
    );
  }
}
