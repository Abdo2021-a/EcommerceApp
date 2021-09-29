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
    "price": "0",
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
    if ((!_imageurlfocusnode.hasFocus) &&
        (!_urlcontrolerimage.text.startsWith("http")) &&
        (!_urlcontrolerimage.text.startsWith("https")) &&
        (!_urlcontrolerimage.text.endsWith("png")) &&
        (!_urlcontrolerimage.text.endsWith("jpg")) &&
        (!_urlcontrolerimage.text.endsWith("jpeg"))) {
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
      Navigator.pop(context);
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
          "price": editproduct.price.toString(),
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
          IconButton(onPressed: () => saveForms(), icon: Icon(Icons.save)),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(8),
              child: Form(
                  key: _formkey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initialvalues["title"],
                        decoration: InputDecoration(labelText: "Title"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_pricefocusnode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your title";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                          editproduct = Product(
                            description: editproduct.description,
                            id: editproduct.id,
                            image_url: editproduct.image_url,
                            is_favourite: editproduct.is_favourite,
                            price: editproduct.price,
                            title: value,
                          );
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        focusNode: _pricefocusnode,
                        initialValue: initialvalues["price"],
                        decoration: InputDecoration(labelText: "price"),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionfocusnode);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your price";
                          }
                          if (double.tryParse(value) == null) {
                            return "please enter valid price";
                          }
                          if (double.tryParse(value) <= 0) {
                            return "please dont enter more that 0";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                          editproduct = Product(
                            description: editproduct.description,
                            id: editproduct.id,
                            image_url: editproduct.image_url,
                            is_favourite: editproduct.is_favourite,
                            price: double.parse(value),
                            title: editproduct.title,
                          );
                        },
                      ),
                      TextFormField(
                        focusNode: _descriptionfocusnode,
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        initialValue: initialvalues["description"],
                        decoration: InputDecoration(labelText: "description"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return "please enter your price";
                          }
                          if (value.length <= 10) {
                            return "please enter more description";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          print(value);
                          editproduct = Product(
                            description: value,
                            id: editproduct.id,
                            image_url: editproduct.image_url,
                            is_favourite: editproduct.is_favourite,
                            price: editproduct.price,
                            title: editproduct.title,
                          );
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _urlcontrolerimage.text.isEmpty
                                  ? Center(
                                      child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text("please enter your Url"),
                                    ))
                                  : FittedBox(
                                      child: Image.network(
                                          _urlcontrolerimage.text),
                                    )),
                          Expanded(
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              focusNode: _imageurlfocusnode,
                              controller: _urlcontrolerimage,
                              decoration:
                                  InputDecoration(labelText: "url image"),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "please enter your description";
                                }
                                if ((!_urlcontrolerimage.text
                                        .startsWith("http")) &&
                                    (!_urlcontrolerimage.text
                                        .startsWith("https")) &&
                                    (!_urlcontrolerimage.text
                                        .endsWith("png")) &&
                                    (!_urlcontrolerimage.text
                                        .endsWith("jpg")) &&
                                    (!_urlcontrolerimage.text
                                        .endsWith("jpeg"))) {
                                  return "please enter a valid url";
                                }

                                return null;
                              },
                              onSaved: (value) {
                                print(value);
                                editproduct = Product(
                                  description: editproduct.description,
                                  id: editproduct.id,
                                  image_url: editproduct.image_url,
                                  is_favourite: editproduct.is_favourite,
                                  price: editproduct.price,
                                  title: editproduct.title,
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
