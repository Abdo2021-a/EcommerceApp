import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/auth.dart';
import 'package:shopapp/Screens/auth_screen.dart';
import 'package:shopapp/Widgets/app_drawer.dart';

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("shop"),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Text("homescreen home screen"),
      ),
    );
  }
}
