import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/orders.dart';
import 'package:shopapp/Widgets/app_drawer.dart';
import 'package:shopapp/Widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const orderscreen_routename = "/orders-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("your orders"),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: Provider.of<Orders>(context).fetchAndSetProducts(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError != null) {
                return Center(
                  child: Text(" an eror"),
                );
              }
              return Consumer<Orders>(
                builder: (ctx, orders, child) {
                  return ListView.builder(
                      itemCount: orders.ordersitems.length,
                      itemBuilder: (ctx, index) {
                        return Text("");
                      });
                },
              );
            }));
  }
}
