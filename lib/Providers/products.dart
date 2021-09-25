import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopapp/Models/http_exceptios.dart';
import 'package:shopapp/Providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      image_url:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      image_url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      image_url:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      image_url:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];
  String authToken;
  String userId;

  void getData(String token, String uid, List<Product> products) {
    authToken = token;
    userId = uid;
    _items = products;
    notifyListeners();
  }

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favouriteitems {
    return _items.where((element) => element.is_favourite).toList();
  }

  Product getMyId(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterbyuser = false]) async {
    // String Filterusers =
    //     filterbyuser ? ' orderBy="creatorId"&equalTo="$userId"' : '';
    // final url =
    //     "https://shopapp-6acbf-default-rtdb.firebaseio.com/products.json?auth=$authToken&$Filterusers";
    // try {
    //   var res = await http.get(Uri.parse(url));

    //   final productsdata = json.decode(res.body) as Map<String, dynamic>;
    //   if (productsdata == null) {
    //     return;
    //   }
    //   final urlfav =
    //       "https://shopapp-6acbf-default-rtdb.firebaseio.com/userFavourites/$userId.json?auth=$authToken";
    //   final favres = await http.get(Uri.parse(urlfav));
    //   final favouritedata = json.decode(favres.body);

    // List<Product> loadedproducts = [];
    // productsdata.forEach((prduct_id, productdata) {
    //   loadedproducts.add(Product(
    //     id: prduct_id,
    //     description: productdata["description"],
    //     title: productdata["title"],
    //     price: productdata["price"],
    //     image_url: productdata["imageUrl"],
    //     is_favourite:
    //         favouritedata == null ? false : favouritedata[prduct_id] ?? false,
    //   ));
    // });
    // _items = loadedproducts;
    // notifyListeners();
    // } catch (eror) {
    //   throw eror;
    // }
  }

  Future<void> addProduct(Product addproduct) async {
    final url =
        "https://shopapp-6acbf-default-rtdb.firebaseio.com/products.json?auth=$authToken";
    ;
    try {
      final res_addproduct = await http.post(Uri.parse(url),
          body: json.encode({
            "title": addproduct.title,
            "description": addproduct.description,
            "imageUrl": addproduct.image_url,
            "price": addproduct.price,
            "creatorId": userId,
          }));
      final newproduct = Product(
        id: json.decode(res_addproduct.body)["name"],
        description: addproduct.description,
        image_url: addproduct.image_url,
        price: addproduct.price,
        title: addproduct.title,
      );
      _items.add(newproduct);
      notifyListeners();
    } catch (eror) {
      throw eror;
    }
  }

  Future<void> updateProduct(String id, Product updateproduct) async {
    final url =
        "https://shopapp-6acbf-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";

    try {
      final product_index = _items.indexWhere((element) => element.id == id);
      if (product_index > 0) {
        final resupdate_product = await http.patch(Uri.parse(url),
            body: json.encode({
              "title": updateproduct.title,
              "description": updateproduct.description,
              "imageUrl": updateproduct.image_url,
              "price": updateproduct.price,
            }));
        _items[product_index] = updateproduct;
        notifyListeners();
      } else {
        return;
      }
    } catch (eror) {
      throw eror;
    }
  }

  Future<void> deleteProduct(String id, Product updateproduct) async {
    final url =
        "https://shopapp-6acbf-default-rtdb.firebaseio.com/products/$id.json?auth=$authToken";
    final indexproduct_delete =
        _items.indexWhere((element) => element.id == id);
    var exictsproduct_index = _items[indexproduct_delete];
    _items.removeAt(indexproduct_delete);

    notifyListeners();
    final res_delete = await http.delete(Uri.parse(url));
    if (res_delete.statusCode >= 400) {
      _items.insert(indexproduct_delete, exictsproduct_index);
      notifyListeners();
      throw HttpException("cant delete this product");
    }

    exictsproduct_index = null;
    notifyListeners();
  }
}
