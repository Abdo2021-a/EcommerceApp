import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product.dart';
import 'Providers/auth.dart';

import 'Providers/card.dart';
import 'Providers/orders.dart';
import 'Providers/products.dart';
import 'Screens/card_screen.dart';
import 'Screens/edit_product_screen.dart';
import 'Screens/orders_screen.dart';
import 'Screens/product_overview_screen.dart';
import 'Screens/product_screen_details.dart';
import 'Screens/user_prduct_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Orders()),
        ChangeNotifierProvider.value(value: Product()),
        ChangeNotifierProvider.value(value: Products()),
        ChangeNotifierProvider.value(value: CardProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(primaryColor: Colors.purple, fontFamily: "Lato"),
        debugShowCheckedModeBanner: false,
        home: ProductDetailsScreen(),
        routes: {
          ProductDetailsScreen.Productdetailsscreen_routename: (_) {
            return ProductDetailsScreen();
          },
          CardScreen.caedscreen_routename: (_) {
            return CardScreen();
          },
          OrdersScreen.orderscreen_routename: (_) {
            return OrdersScreen();
          },
          UserProductScreen.userproductscreen_routename: (_) {
            return UserProductScreen();
          },
          EditProductScreen.editproduct_routename: (_) {
            return EditProductScreen();
          }
        },
      ),
    );
  }
}
