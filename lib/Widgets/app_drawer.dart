import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/auth.dart';
import 'package:shopapp/Screens/auth_screen.dart';
import 'package:shopapp/Screens/orders_screen.dart';
import 'package:shopapp/Screens/user_prduct_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Ecommerce App"),
          ),
          ListTile(
              title: Text("Shop"),
              leading: Icon(Icons.shop),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              }),
          Divider(),
          ListTile(
              title: Text("Orders"),
              leading: Icon(Icons.payment_outlined),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.orderscreen_routename);
              }),
          Divider(),
          ListTile(
              title: Text("Manage Your Order"),
              leading: Icon(Icons.edit),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(
                    UserProductScreen.userproductscreen_routename);
              }),
          Divider(),
          ListTile(
              title: Text("Log Out"),
              leading: Icon(Icons.logout),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logOut();
                Navigator.of(context)
                    .pushReplacementNamed(AuthScreen.authscreen_routename);
              }),
          Divider(),
        ],
      ),
    );
  }
}
// AuthScreen.authscreen_routename