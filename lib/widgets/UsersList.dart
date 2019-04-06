import 'package:flutter/material.dart';
import './User.dart';

class UsersList extends StatelessWidget {
  final List<String> users;

  UsersList({@required this.users});

  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: this.users.length,
      itemBuilder: (BuildContext context, int index) {
        return new User();
      },
    )));
  }
}
