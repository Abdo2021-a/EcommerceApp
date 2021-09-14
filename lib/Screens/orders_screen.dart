import 'package:flutter/material.dart';
import 'package:shopapp/Widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const orderscreen_routename = "/orders-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Container(
        child: Center(child: Text("order screen")),
      ),
    );
  }
}
