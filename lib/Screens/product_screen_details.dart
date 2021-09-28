import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const Productdetailsscreen_routename = "/product-details-screen";

  @override
  Widget build(BuildContext context) {
    final productid = ModalRoute.of(context).settings.arguments;
    final dataof_productid = Provider.of<Products>(context).getMyId(productid);
    print(productid);

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(dataof_productid.title),
            background: Hero(
              tag: productid,
              child: Image.network(
                dataof_productid.image_url,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          SizedBox(
            height: 10,
          ),
          Text(
            "\$${dataof_productid.price}",
            style: TextStyle(color: Colors.grey, fontSize: 25),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            child: Text(
              "${dataof_productid.description}",
              style: TextStyle(fontSize: 25),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
        ])),
      ],
    ));
  }
}
