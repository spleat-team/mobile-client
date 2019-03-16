import 'package:flutter/material.dart';
import '../classes/dish.dart';

class DishWidget extends StatelessWidget {
  final Dish dish;

  const DishWidget(this.dish);

  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        child: ListTile(
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.black))),
              child: Icon(
                Icons.restaurant,
                color: Colors.black,
                size: 40.0,
              ),
            ),
            title: Text(
              dish.name,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

            subtitle: Column(children: <Widget>[
              Row(
                children: <Widget>[
                  //Icon(Icons.confirmation_number, color: Colors.black),
                  Text("Total amount: ", style: TextStyle(color: Colors.black)),
                  Text(dish.amount.toString(),
                      style: TextStyle(color: Colors.black))
                ],
              ),
              Row(
                children: <Widget>[
                  Text("My amount: ", style: TextStyle(color: Colors.black)),
                  Text("0", style: TextStyle(color: Colors.black))
                ],
              ),
              Row(
                children: <Widget>[
                  Text("Price per dish: ",
                      style: TextStyle(color: Colors.black)),
                  Text(dish.price.toString(),
                      style: TextStyle(color: Colors.black))
                ],
              )
            ]),
            trailing: Container(
                width: 80.0,
                child: Row(children: <Widget>[
                  Icon(Icons.add, color: Colors.green.shade500, size: 40.0),
                  Icon(Icons.remove, color: Colors.red.shade500, size: 40.0)
                ]))),
      ),
    );
  }
}
