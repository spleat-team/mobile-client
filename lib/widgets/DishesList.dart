import 'package:flutter/material.dart';
import './DishWidget.dart';
import '../classes/dish.dart';

class DishesList extends StatelessWidget {
  final List<Dish> dishes;

  DishesList(this.dishes);

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: new ListView.builder(
          itemCount: this.dishes.length,
          itemBuilder: (BuildContext context, int index) {
            return new DishWidget(this.dishes[index]);
          },
        ),
      )
    ]);
  }
}
