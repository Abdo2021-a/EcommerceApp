import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/card.dart' show CartProvider;
import 'package:shopapp/Providers/orders.dart';
import 'package:shopapp/Widgets/cart_item.dart';

class CardScreen extends StatelessWidget {
  static const caedscreen_routename = "/card-screen";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("My Cart"),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 25),
                  ),
                  Spacer(),
                  Chip(
                    backgroundColor: Theme.of(context).primaryColor,
                    label: Text(
                      "\$ ${cart.totalamount.toStringAsFixed(2)}",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  OrderButton(cart: cart),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (BuildContext context, int index) {
                return CartItem(
                  id: cart.items.values.toList()[index].id,
                  price: cart.items.values.toList()[index].price,
                  productid: cart.items.keys.toList()[index],
                  quantity: cart.items.values.toList()[index].quantity,
                  title: cart.items.values.toList()[index].title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  CartProvider cart;
  OrderButton({this.cart});
  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: widget.cart.totalamount <= 0
            ? null
            : () async {
                setState(() {
                  isloading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrders(
                    widget.cart.items.values.toList(), widget.cart.totalamount);

                setState(() {
                  isloading = false;
                });
                widget.cart.clearItem();
              },
        child: isloading
            ? CircularProgressIndicator()
            : Chip(
                label: Text(
                  "Order Now",
                  style: TextStyle(
                      color: widget.cart.totalamount <= 0
                          ? Colors.grey
                          : Theme.of(context).primaryColor),
                ),
              ));
  }
}
