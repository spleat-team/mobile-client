import './dish.dart';

class Receipt {
  List<Dish> dishes;
  String pincode;
  int numOfPeople;
  double price;

  Receipt(List<Dish> dishes, String pincode, int numOfPeople, double price) {
    this.dishes = dishes;
    this.pincode = pincode;
    this.numOfPeople = numOfPeople;
    this.price = price;
  }

  static buildFromJson(dynamic dishes) {
    List<Dish> list = new List();
    dishes.forEach((v) {
      list.add(Dish(v["userIds"], v["name"], v["amount"],
          double.parse(v["price"].toString())));
    });
    return list;
  }

  getPincode() {
    return this.pincode;
  }
}
