import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Providers/product.dart';
import 'package:shopapp/Providers/products.dart';
import 'package:shopapp/Screens/card_screen.dart';
import 'package:shopapp/Widgets/app_drawer.dart';

class EditProductScreen extends StatefulWidget {
  static const editproduct_routename = "/edit-product-screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _pricefocusnode = FocusNode();
  final _descriptionfocusnode = FocusNode();
  final _imageurlfocusnode = FocusNode();
  final _urlcontrolerimage = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  Product editproduct =
      Product(description: "", id: null, image_url: "", price: 0, title: "");
  Map<String, dynamic> initialvalues = {
    "description": "",
    "image_url": "",
    "price": 0,
    "title": "",
  };
  bool _isinit = true;
  bool _isloading = false;

  @override
  void dispose() {
    print("dispose run");
    super.dispose();
    _imageurlfocusnode.removeListener(_updateImageurl);
    _urlcontrolerimage.dispose();
    _pricefocusnode.dispose();
    _descriptionfocusnode.dispose();
    print("dispose done");
  }

  _updateImageurl() {
    if (!_imageurlfocusnode.hasFocus &&
        _urlcontrolerimage.text.startsWith("http") &&
        _urlcontrolerimage.text.startsWith("https") &&
        _urlcontrolerimage.text.endsWith("png") &&
        _urlcontrolerimage.text.endsWith("jpg") &&
        _urlcontrolerimage.text.endsWith("jpeg")) {
      return;
    }
    setState(() {});
  }

  Future saveForms() async {
    final isvalid = _formkey.currentState.validate();
    if (!isvalid) {
      return;
    }
    _formkey.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (editproduct.id != null) {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(editproduct.id, editproduct);
    } else {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(editproduct);
      } catch (eror) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text("an error occurred"),
                content: Text("some thomg worng $eror "),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("okey"))
                ],
              );
            });
      }
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  void initState() {
    print("initstata run");
    super.initState();
    _imageurlfocusnode.addListener(_updateImageurl);
    print("initstata done");
  }

  @override
  void didChangeDependencies() {
    print(" didChangeDependencies run");
    super.didChangeDependencies();
    if (_isinit) {
      final product_id = ModalRoute.of(context).settings.arguments as String;
      if (product_id != null) {
        var editproduct =
            Provider.of<Products>(context, listen: false).getMyId(product_id);

        print(editproduct.title);
        initialvalues = {
          "description": editproduct.description,
          "image_url": "",
          "price": editproduct.price,
          "title": editproduct.title,
        };
        _urlcontrolerimage.text = editproduct.image_url;
      }

      _isinit = false;
    }
    _isinit = false;
    print(" didChangeDependencies done");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("edit product"),
        actions: [
          IconButton(onPressed: () => saveForms(), icon: Icon(Icons.save))
        ],
      ),
      body: Container(
          child: Center(
        child: Text("edit product screen"),
      )),
    );
  }
}
