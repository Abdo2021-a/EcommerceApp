import 'package:flutter/material.dart';
import 'package:shopapp/Widgets/app_drawer.dart';

class UserProductScreen extends StatelessWidget {
  static const userproductscreen_routename = "/user-product-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Container(
        child: Center(child: Text("manage your  order")),
      ),
    );
  }
}
