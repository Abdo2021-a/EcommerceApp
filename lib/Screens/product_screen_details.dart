import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const Productdetailsscreen_routename = "/product-details-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ProductDetails"),
      ),
      body: Container(
        child: Center(
          child: Text("ProductDetailsScreen"),
        ),
      ),
    );
  }
}