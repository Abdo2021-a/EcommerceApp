import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/auth.dart';
import 'package:shopapp/Providers/card.dart';
import 'package:shopapp/Providers/product.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Screens/product_screen_details.dart';

class ProductItem extends StatelessWidget {
  bool sss = false;
  @override
  Widget build(BuildContext context) {
    var product = Provider.of<Product>(context);
    var products = Provider.of<Products>(context);
    var card = Provider.of<CartProvider>(context);
    var auth = Provider.of<Auth>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (context, prodduct, _) {
                return IconButton(
                    onPressed: () async {
                      print("dona");
                      await prodduct.toggleIsFavouritestatuse(
                          auth.token, auth.userid);
                    },
                    //  change sss to product.is_favourite
                    icon: sss
                        ? Icon(Icons.favorite)
                        : Icon(Icons.favorite_border));
              },
            ),
            backgroundColor: Colors.blueGrey,
            subtitle: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
                onPressed: () {
                  card.addItem(product.id, product.price, product.title);

                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      content: Text("add to your shop"),
                      duration: Duration(seconds: 3),
                      action: SnackBarAction(
                        label: "undo",
                        onPressed: () {
                          card.removeSingleItem(product.id);
                        },
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart)),
          ),
          child: GestureDetector(
            onTap: () {
              print(product.id);
              print("heed");
              return Navigator.pushNamed(
                  context, ProductDetailsScreen.Productdetailsscreen_routename,
                  arguments: product.id);
            },
            child: Hero(
              tag: product.id,
              child: FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage(
                  "assets/images/product-placeholder.png",
                ),
                image: NetworkImage(
                  product.image_url,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
