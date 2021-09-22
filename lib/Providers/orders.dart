import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'card.dart';

class OrderModel {
  double amount;
  String id;
  List<CartItem> products;
  DateTime dateTime;
  OrderModel({this.amount, this.dateTime, this.id, this.products});
}

class Orders with ChangeNotifier {
  String authToken;
  String userId;
  List<OrderModel> _ordersitems = [];
  getData(String auth_token, String uid, List<OrderModel> ordersitems) {
    authToken = auth_token;
    userId = uid;
    _ordersitems = ordersitems;
    notifyListeners();
  }

  List<OrderModel> get ordersitems {
    return [..._ordersitems];
  }

  Future<void> fetchAndSetProducts() async {
    final url =
        "https://shopapp-6acbf-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    try {
      var resordersitems = await http.get(Uri.parse(url));
      final extracteddata =
          json.decode(resordersitems.body) as Map<String, dynamic>;
      if (extracteddata == null) {
        return;
      } else {
        List<OrderModel> loadedorders = [];
        extracteddata.forEach((orderid, orderdata) {
          loadedorders.add(OrderModel(
            id: orderid,
            amount: orderdata['amount'],
            dateTime: DateTime.parse(orderdata['datetime']),
            products: (orderdata["products"] as List<dynamic>)
                .map((e) => CartItem(
                    id: e["id"],
                    price: e["price"],
                    quantity: e["quantity"],
                    title: e["title"]))
                .toList(),
          ));
        });

        _ordersitems = loadedorders.reversed.toList();
        notifyListeners();
      }
    } catch (eror) {}
  }

  Future<void> addOrders(List<CartItem> carditems, double total) async {
    DateTime dateTime = DateTime.now();
    final url =
        "https://shopapp-6acbf-default-rtdb.firebaseio.com/orders/$userId.json?auth=$authToken";
    try {
      final resdata = await http.post(
        Uri.parse(url),
        body: json.encode({
          "amount": total,
          "datetime": dateTime.toIso8601String(),
          "products": carditems
              .map((e) => {
                    "id": e.id,
                    "price": e.price,
                    "quantity": e.quantity,
                    "title": e.title,
                  })
              .toList()
        }),
      );
      final extracteddata_orders = json.decode(resdata.body);
      _ordersitems.insert(
          0,
          OrderModel(
            amount: total,
            id: extracteddata_orders['name'],
            dateTime: dateTime,
            products: carditems,
          ));
      notifyListeners();
    } catch (eror) {}
  }
}
