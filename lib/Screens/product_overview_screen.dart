import 'package:flutter/material.dart';
import 'package:shopapp/Screens/auth_screen.dart';

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return AuthScreen();
            }));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Text("homescreen"),
      ),
    );
  }
}
