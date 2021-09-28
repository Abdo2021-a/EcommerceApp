import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/card.dart';

class CartItem extends StatelessWidget {
  String id;
  String productid;
  int quantity;
  double price;
  String title;
  CartItem({this.id, this.price, this.productid, this.quantity, this.title});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          margin: EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (ditect) {
          return showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("are you sure"),
                  content: Text("delete this Order"),
                  actions: [
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Text("yes")),
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text("no")),
                  ],
                );
              });
        },
        onDismissed: (direction) {
          Provider.of<CartProvider>(context, listen: false)
              .removeItem(productid);
        },
        key: ValueKey(id),
        child: Card(
          margin: EdgeInsets.all(10),
          child: Padding(
              padding: const EdgeInsets.all(2),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: FittedBox(
                      child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "$price",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
                ),
                title: Text(title),
                subtitle: Text("total : ${price * quantity} "),
                trailing: Text("$quantity x"),
              )),
        ));
  }
}
