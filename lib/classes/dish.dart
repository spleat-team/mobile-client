class Dish {
  List<String> userIds;
  String name;
  int amount;
  double price;

  Dish(List<String> userIds, String name, int amount, double price) {
    this.userIds = userIds;
    this.name = name;
    this.amount = amount;
    this.price = price;
  }
}
