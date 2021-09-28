import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Screens/edit_product_screen.dart';
import 'package:shopapp/Widgets/app_drawer.dart';
import 'package:shopapp/Widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const userproductscreen_routename = "/user-product-screen";
  Future<void> getFavouriteData(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your products"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, EditProductScreen.editproduct_routename);
                },
                icon: Icon(Icons.add))
          ],
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
            future: getFavouriteData(context),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return RefreshIndicator(
                onRefresh: () => getFavouriteData(context),
                child: Consumer<Products>(
                  builder: (ctx, productdata, child) {
                    return ListView.builder(
                        itemCount: productdata.items.length,
                        itemBuilder: (ctx, index) {
                          return Column(
                            children: [
                              UserProductItem(
                                id: productdata.items[index].id,
                                image_url: productdata.items[index].image_url,
                                title: productdata.items[index].title,
                              ),
                              Divider(),
                            ],
                          );
                        });
                  },
                ),
              );
            }));
  }
}
