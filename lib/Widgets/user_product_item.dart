import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String image_url;
  UserProductItem({this.title, this.id, this.image_url});

  @override
  Widget build(BuildContext context) {
    print(id);
    return ListTile(
      title: Text("$title"),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(image_url),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () async {
                  print(id);
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                    print("done");
                  } catch (eror) {
                    Fluttertoast.showToast(
                        msg: "fail delete",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.black87,
                )),
            IconButton(
                onPressed: () {
                  print(id);
                  Navigator.pushNamed(
                      context, EditProductScreen.editproduct_routename,
                      arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Colors.black87,
                )),
          ],
        ),
      ),
    );
  }
}
