import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  double price;
  int quantity;
  CartItem({this.id, this.price, this.quantity, this.title});
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};
  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemcount {
    return _items.length;
  }

  double get totalamount {
    var total = 0.0;
    _items.forEach((key, cartof_item) {
      total += cartof_item.price * cartof_item.quantity;
      notifyListeners();
    });
    return total;
  }

  void addItem(String productid, double price, String title) {
    if (_items.containsKey(productid)) {
      _items.update(
          productid,
          (value) => CartItem(
              id: value.id,
              price: value.price,
              title: value.title,
              quantity: value.quantity + 1));
    } else {
      _items.putIfAbsent(
          productid,
          () => CartItem(
                id: DateTime.now().toString(),
                price: price,
                quantity: 1,
                title: title,
              ));
    }
    notifyListeners();
  }

  void removeItem(String prodid) {
    _items.remove(prodid);
    notifyListeners();
  }

  void removeSingleItem(String prodid) {
    if (!_items.containsKey(prodid)) {
      return;
    }
    if (_items[prodid].quantity > 1) {
      _items.update(
          prodid,
          (value) => CartItem(
                id: value.id,
                title: value.title,
                price: value.price,
                quantity: value.quantity - 1,
              ));
    } else {
      _items.remove(prodid);
    }
    notifyListeners();
  }

  void clearItem() {
    _items = {};
    notifyListeners();
  }
}
