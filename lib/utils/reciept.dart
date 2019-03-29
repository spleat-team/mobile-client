import '../classes/receipt.dart';
import '../classes/dish.dart';
import '../constants/const.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:core';

Future<Receipt> getReceipt(String pincode) {
  return http.get(SERVER_URL + '/receipts/' + pincode).then((response) {
    if (response.body != "") {
      return convertReceiptFromJSON(response.body);
    }
    return null;
  }).catchError((err) {
    print(err);
    return null;
  });
}

Future<Receipt> sendReceipt(String base64Image, int numOfPeople) {
  return http
      .post(
    SERVER_URL + '/receipts',
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: JsonEncoder().convert(
        {'picture': base64Image, 'numOfPeople': numOfPeople.toString()}),
  )
      .then((response) {
    return convertReceiptFromJSON(response.body);
  }).catchError((error) {
    print(error);
    return null;
  });
}

Receipt convertReceiptFromJSON(String json) {
  dynamic c = JsonDecoder().convert(json);
  List<Dish> dishes = Receipt.buildFromJson(c["dishes"]);
  Receipt r = Receipt(dishes, c["pincode"], c["numOfPeople"],
      double.parse(c["price"].toString()));
  return r;
}
