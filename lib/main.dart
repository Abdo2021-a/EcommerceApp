import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product.dart';
import 'package:shopapp/Screens/splash_screen.dart';
import 'Providers/auth.dart';

import 'Providers/card.dart';
import 'Providers/orders.dart';
import 'Providers/products.dart';
import 'Screens/auth_screen.dart';
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
      child: Consumer<Auth>(
        builder: (context, snap, _) {
          return MaterialApp(
            theme: ThemeData(primaryColor: Colors.purple, fontFamily: "Lato"),
            debugShowCheckedModeBanner: false,
            home: snap.isauth
                ? ProductOverViewScreen()
                : FutureBuilder(
                    future: snap.autoLogIn(),
                    builder: (ctx, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SplashScreen();
                      } else {
                        return AuthScreen();
                      }
                    }),
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
              },
              AuthScreen.authscreen_routename: (_) {
                return AuthScreen();
              },
            },
          );
        },
      ),
    );
  }
}
