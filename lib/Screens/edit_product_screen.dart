import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Widgets/app_drawer.dart';

class EditProductScreen extends StatelessWidget {
  static const editproduct_routename = "/edit-product-screen";

  @override
  Widget build(BuildContext context) {
    final _productid = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text("edit your product"),
        ),
        body: Container(
          child: Center(
            child: Text("edit product screen"),
          ),
        ));
  }
}
