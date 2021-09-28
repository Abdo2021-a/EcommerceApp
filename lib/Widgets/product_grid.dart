import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Widgets/product_item.dart';

class ProductsGrid extends StatelessWidget {
  bool show_fav;
  ProductsGrid(this.show_fav);
  @override
  Widget build(BuildContext context) {
    final product_data = Provider.of<Products>(context);
    final products =
        show_fav ? product_data.favouriteitems : product_data.items;

    return products.isEmpty
        ? Center(
            child: Text("no product added"),
          )
        : GridView.builder(
            itemCount: products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemBuilder: (context, i) => ChangeNotifierProvider.value(
                value: products[i], child: ProductItem()),
          );
  }
}
