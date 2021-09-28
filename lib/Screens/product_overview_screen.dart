import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/auth.dart';
import 'package:shopapp/Providers/card.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Screens/auth_screen.dart';
import 'package:shopapp/Screens/card_screen.dart';
import 'package:shopapp/Screens/product_screen_details.dart';
import 'package:shopapp/Widgets/app_drawer.dart';
import 'package:shopapp/Widgets/badge.dart';
import 'package:shopapp/Widgets/product_grid.dart';
import 'package:shopapp/Widgets/product_item.dart';

enum Filterd_shop { isFvavourite, allShop }

class ProductOverViewScreen extends StatefulWidget {
  @override
  _ProductOverViewScreenState createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  bool is_loding = false;

  bool is_init = false;
  bool show_onlyfavourite = false;
  @override
  void initState() {
    // TODO: implement initState
    is_loding = true;
    //  return to true
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then((value) {
      setState(() {
        is_loding = false;
      });
    }).catchError((onError) {
      setState(() {
        is_loding = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Shop"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              onSelected: (Filterd_shop selectedvalue) {
                print(selectedvalue);
                setState(() {
                  if (selectedvalue == Filterd_shop.isFvavourite) {
                    show_onlyfavourite = true;
                  } else {
                    show_onlyfavourite = false;
                  }
                });
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("all shop"),
                  value: Filterd_shop.allShop,
                ),
                PopupMenuItem(
                    child: Text("my favoutites"),
                    value: Filterd_shop.isFvavourite),
              ],
            ),
            Consumer<CartProvider>(
              child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, CardScreen.caedscreen_routename);
                  },
                  icon: Icon(Icons.shopping_cart)),
              builder: (ctx, card, childicon) {
                return Badge(
                    Child: childicon, value: card.itemcount.toString());
              },
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: is_loding
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ProductsGrid(show_onlyfavourite));
  }
}
