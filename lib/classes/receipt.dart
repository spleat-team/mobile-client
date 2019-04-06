import './dish.dart';

class Receipt {
  List<Dish> dishes;
  List<String> users;
  String pincode;
  int numOfPeople;
  double price;

  Receipt(List<Dish> dishes, List<String> users, String pincode,
      int numOfPeople, double price) {
    this.users = users;
    this.dishes = dishes;
    this.pincode = pincode;
    this.numOfPeople = numOfPeople;
    this.price = price;
  }

  static buildDishesFromJson(dynamic dishes) {
    List<Dish> list = new List();
    dishes.forEach((v) {
      list.add(Dish(v["userIds"], v["name"], v["amount"],
          double.parse(v["price"].toString())));
    });
    return list;
  }

  static buildReceiptFromJson(String pincode, dynamic receipt) {
    try {
      List<String> users = receipt["users"].cast<String>();
      List<Dish> dishes = new List();
      receipt["dishes"].forEach((v) {
        List<String> userIds = v["userIds"].cast<String>();
        dishes.add(Dish(userIds, v["name"], v["amount"],
            double.parse(v["price"].toString())));
      });
      return new Receipt(dishes, users, pincode, receipt["numOfPeople"],
          double.parse(receipt["price"].toString()));
    } catch (err) {
      return null;
    }
  }

  getPincode() {
    return this.pincode;
  }
}
