import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String image_url;
  bool is_favourite = false;
  Product(
      {this.id,
      this.description,
      this.image_url,
      this.is_favourite,
      this.price,
      this.title});
  @override
  void _setValueFavpurite(bool newvalue) {
    is_favourite = newvalue;
    notifyListeners();
  }

  Future<void> toggleIsFavouritestatuse(String token, String userid) async {
    final oldvalue = is_favourite;
    is_favourite = !is_favourite;
    notifyListeners();
    String url = "";
    try {
      var res = await http.put(url, body: json.encode(is_favourite));
      if (res.statusCode >= 400) {
        _setValueFavpurite(oldvalue);
      }
    } catch (eror) {
      _setValueFavpurite(oldvalue);
    }
  }
}
